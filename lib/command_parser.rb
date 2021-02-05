require_relative 'paybackservice'
require_relative 'user'
require_relative 'merchant'
class CommandParser

  def initialize
    @payback_service = PayBackService.new
  end

  def parse(buf)
    cmd_array = buf.split(" ")
    if cmd_array[0] == 'new'
      return parse_new_command(cmd_array)
    end
    if cmd_array[0] == 'report'
      return report(cmd_array)
    end
    if cmd_array[0] == 'payback'
      return payback(cmd_array)
    end
    return 'Command not recognized'
  end

  def parse_new_command(cmd_array)
    if cmd_array[1] == 'user'
      user = User.new(cmd_array[2], cmd_array[3], cmd_array[4].to_i)
      @payback_service.onboard_user(user)
      return "#{user.name} (#{user.credit_limit})"
    end
    if cmd_array[1] == 'merchant'
      discount_percentage = cmd_array[4].delete_suffix('%').to_f
      merchant = Merchant.new(cmd_array[2],cmd_array[3],discount_percentage)
      @payback_service.onboard_merchant(merchant)
      return "#{merchant.name} (#{merchant.discount_percentage}%)"
    end
    if cmd_array[1] == 'txn'
      return transact(cmd_array)
    end

    return "Format of 'new' command invalid. Please check input"
  end

  private

  def transact(cmd_array)
    user = find_user_by_name(cmd_array[2])
    return "User #{cmd_array[2]} not found" unless user

    merchant = find_merchant_by_name(cmd_array[3])
    return "Merchant #{cmd_array[3]} not found" unless merchant

    amount = cmd_array[4].to_i
    result = @payback_service.transact(user, merchant, amount)
    if result
      return 'success!'
    else
      return 'rejected! (reason: credit limit)'
    end
  end

  def report(cmd_array)
    if cmd_array[1] == 'users-at-credit-limit'
      output_string = String.new
      @payback_service.users_at_credit_limit.each do |user|
        output_string += user.name + "\n"
      end
      return output_string
    end
    if cmd_array[1] == 'discount'
      merchant = find_merchant_by_name(cmd_array[2])
      return "merchant with name ''#{cmd_array[2]}'' not found" unless merchant
      return merchant.total_discount_received
    end
    if cmd_array[1] == 'total-dues'
      total_dues = 0
      output_string = String.new
      @payback_service.users.each do |user|
        if user.dues > 0
          output_string += "#{user.name}: #{user.dues}" + "\n"
          total_dues += user.dues
        end
      end
      output_string += "total: #{total_dues}"
      return output_string
    end
    false
  end

  def payback(cmd_array)
    user = find_user_by_name(cmd_array[1])
    return "Could not find user with name '#{cmd_array[1]}'" unless user
    user.payback(cmd_array[2].to_i)
    return "#{user.name}(dues: #{user.dues})"
  end

  def find_user_by_name(username)
    @payback_service.users.each do |user|
      if user.name == username
        return user
      end
    end
    false
  end

  def find_merchant_by_name(merchant_name)
    @payback_service.merchants.each do |merchant|
      if merchant.name == merchant_name
        return merchant
      end
    end
    false
  end

end