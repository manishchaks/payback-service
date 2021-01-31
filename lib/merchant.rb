class Merchant
  attr_accessor :discount_percentage
  attr_reader :name

  def initialize(name, discount_percentage)
    @name = name
    @discount_percentage = discount_percentage
  end
end
