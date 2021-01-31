require 'paybackservice'
describe PayBackService do
  before :each do
    @paybackservice = PayBackService.new
    @user1 = User.new('user1', 'u1@users.com', 300)
    @user2 = User.new('user2', 'u2@users.com', 400)
    @user3 = User.new('user3', 'u3@users.com', 500)
    @merchant1 = Merchant.new('m1', 'm1@merchants.com',1.5)
    @merchant2 = Merchant.new('m1', 'm2@merchants.com',1.5)
    @merchant3 = Merchant.new('m1', 'm3@merchants.com',1.5)
  end

  context 'Onboarding' do
    it 'should be possible to onboard a valid user' do
      @paybackservice.onboard_user(@user1)
      expect(@paybackservice.users.length).to eq(1)
      @paybackservice.onboard_user(@user2)
      @paybackservice.onboard_user(@user3)
      expect(@paybackservice.users.length).to eq(3)
    end
    it 'should be possible to onboard a valid merchant' do
      @paybackservice.onboard_merchant(@merchant1)
      expect(@paybackservice.merchants.length).to eq(1)
      @paybackservice.onboard_merchant(@merchant2)
      @paybackservice.onboard_merchant(@merchant3)
      expect(@paybackservice.merchants.length).to eq(3)
    end
  end
  context 'Workflow' do
    it 'should be possible to onboard multiple users and merchants and carry out the sample workflow presented' do
      @paybackservice.onboard_user(@user1)
      @paybackservice.onboard_user(@user2)
      @paybackservice.onboard_user(@user3)
      @paybackservice.onboard_merchant(@merchant1)
      @paybackservice.onboard_merchant(@merchant2)
      @paybackservice.onboard_merchant(@merchant3)

      # The exact workflow presented in the example
      # > new txn user2 m1 500
      expect(@paybackservice.transact(@user2, @merchant1, 500)).to eql(false)
      # new txn user1 m2 300
      expect(@paybackservice.transact(@user1, @merchant2, 300)).to eql(true)
      # > new txn user1 m3 10
      expect(@paybackservice.transact(@user1, @merchant3, 10)).to eql(false)
      # > report users-at-credit-limit
      expect(@paybackservice.users_at_credit_limit).to eql([@user1])
      # > new txn user3 m3 200
      expect(@paybackservice.transact(@user3, @merchant3, 200)).to eql(true)
      # > new txn user3 m3 300
      expect(@paybackservice.transact(@user3, @merchant3, 300)).to eql(true)
      # > report users-at-credit-limit
      expect(@paybackservice.users_at_credit_limit).to eql([@user1, @user3])
      expect(@merchant3.total_discount_received).to eql(7.5)
      # > payback user3 400
      @user3.payback(400)
      expect(@user3.dues).to eql(100)
      # > report total-dues
      expect(@user1.dues).to eql(300)


    end
  end
end