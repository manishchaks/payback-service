require 'merchant.rb'
describe Merchant do
  context "Initialization" do
    it "is possible to create a valid merchant object" do
      merchant = Merchant.new('m1', 1.5)
      expect(merchant).to respond_to(:name)
      expect(merchant).to respond_to(:discount_percentage)
      expect(merchant.name).to eq('m1')
      expect(merchant.discount_percentage).to eq(1.5)
    end
  end
end