require_relative 'validator'
class Merchant
  attr_accessor :discount_percentage
  attr_reader :name, :email
  attr_reader :total_discount_received

  def initialize(name, email, discount_percentage)
    # NOTE:
    # I'm using a custom Validator class below
    # In real life, we would be using ActiveRecord Validations or something similar
    #
    Validator.validate_name(name)
    Validator.validate_email(email)
    @name = name
    @email = email
    @discount_percentage = discount_percentage
    @total_discount_received = 0
  end

  def add_discount (discount)
    @total_discount_received = @total_discount_received + discount
  end
end
