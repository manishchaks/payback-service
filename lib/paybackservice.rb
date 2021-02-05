
class PayBackService
  attr_reader :users, :merchants, :transactions
  def initialize
    @users = []
    @merchants = []
    @transactions = []
  end

  def onboard_user(user)
    @users << user
  end

  def onboard_merchant(merchant)
    @merchants << merchant
  end

  def transact (user, merchant, amount)
    if user.can_avail_credit?(amount)
      user.avail_credit(amount)
      merchant.add_discount(amount * merchant.discount_percentage / 100)
      return true
    end
    false
  end

  def users_at_credit_limit
    users_at_credit_limit_array = []
    @users.each do |user|
      users_at_credit_limit_array << user if user.at_credit_limit?
    end
    users_at_credit_limit_array
  end
end
