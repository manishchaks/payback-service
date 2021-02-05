class CommandParser

  def initialize
    @payback_service = PayBackService.new
  end

  def parse(buf)
    p "parsing command"
    if buf.start_with?('new')
      return parse_new_command(buf)
    end
  end

  def parse_new_command(buf)
    cmd_array = buf.split(" ")
    p "parsed array"
    p cmd_array
    #We know the first element is already 'new'
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