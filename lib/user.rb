require_relative 'validator'
class User
  attr_reader :name, :email
  attr_accessor :credit_limit, :available_credit

  def initialize(name, email, credit_limit)
    # NOTE:
    # I'm using a custom Validator class below
    # In real life, we would be using ActiveRecord Validations or something similar
    Validator.validate_credit_limit(credit_limit)
    Validator.validate_name(name)
    Validator.validate_email(email)
    @name = name
    @email = email
    @credit_limit = credit_limit
    @available_credit = @credit_limit
  end

  def at_credit_limit?
    @available_credit <= 0
  end

  def can_avail_credit? amount
    @available_credit >= amount
  end

  def avail_credit amount
    @available_credit = @available_credit - amount if can_avail_credit?(amount)
  end

  def dues
    @credit_limit - @available_credit
  end

  def payback(amount)
    @available_credit = @available_credit + amount
  end
end
