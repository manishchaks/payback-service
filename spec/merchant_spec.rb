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
    it 'is not possible to create a merchant with an empty name' do
      expect{Merchant.new('m1', 1.5).to raise_exception(InvalidNameException,'Name should be at least 1 character long')}
    end
    it 'is not possible to create a merchant with a negative discount percentage' do
      expect{Merchant.new('m1', -1.5).to raise_exception(InvalidDiscountException,'Discount must be greater than or equal to zero')}
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
  context 'Discount' do
    it 'should report the total discount received from merchant correctly' do
      expect(@merchant.total_discount_received).to eql(0)
      @merchant.add_discount(20)
      expect(@merchant.total_discount_received).to eql(20)
      @merchant.add_discount(10)
      expect(@merchant.total_discount_received).to eql(30)
    end
  end
end
