class Merchant
  attr_accessor :name, :discount_percentage

  def initialize(name, discount_percentage)
    @name = name
    @discount_percentage = discount_percentage
  end
end
