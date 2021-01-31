require 'paybackservice'
describe PayBackService do
  before :each do
    @paybackservice = PayBackService.new
  end
  context 'Onboarding' do
    it 'should be possible to onboard a valid user' do
      @user = User.new('user1', 'user@gmail.com', 500)
      @paybackservice.onboard_user(@user)
      expect(@paybackservice.users.length).to eq(1)
    end
    it 'should be possible to onboard a valid merchant' do
      @merchant = Merchant.new('m1', 1.5)
      @paybackservice.onboard_merchant(@merchant)
      expect(@paybackservice.merchants.length).to eq(1)
    end
  end
end