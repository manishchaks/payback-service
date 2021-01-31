require 'merchant.rb'
describe Merchant do
  before :each do
    @merchant = Merchant.new('m1', 1.5)
  end
  context 'Initialization' do
    it 'is possible to create a valid merchant object' do
      expect(@merchant).to respond_to(:name)
      expect(@merchant).to respond_to(:discount_percentage)
      expect(@merchant.name).to eq('m1')
      expect(@merchant.discount_percentage).to eq(1.5)
    end
  end
  context 'Updation' do
    it 'is possible to update discount-percentage' do
      @merchant.discount_percentage = 2.5
      expect(@merchant.discount_percentage).to eq(2.5)
    end
    it 'is not possible to update the name of a merchant after creation' do
      expect(@merchant).to_not respond_to(:name=)
    end
  end
end
