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
end
