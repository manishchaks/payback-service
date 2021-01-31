require 'user.rb'

describe User do
  before :each do
    @user = User.new('user1', 'user@gmail.com', 500)
  end
  context 'Initialization' do
    it 'is possible to create a valid user object' do
      expect(@user).to respond_to(:name)
      expect(@user).to respond_to(:email)
      expect(@user).to respond_to(:credit_limit)
      expect(@user.name).to eq('user1')
      expect(@user.email).to eq('user@gmail.com')
      expect(@user.credit_limit).to eq(500)
    end
  end
  context 'Updation' do
    it 'is not possible to change the email and name' do
      expect(@user).to_not respond_to(:name=)
      expect(@user).to_not respond_to(:email=)
    end
  end
end