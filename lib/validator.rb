require_relative 'exceptions/invalid_credit_limit_exception'
require_relative 'exceptions/invalid_name_exception'
require_relative 'exceptions/invalid_email_exception'
require_relative 'exceptions/invalid_discount_exception'

class Validator
  def self.validate_credit_limit(cred_limit)
    if cred_limit <= 0
      raise InvalidCreditLimitException.new('Credit Limit cannot be less than or equal to zero')
    end
  end

  def self.validate_discount(discount)
    if discount <= 0
      raise InvalidDiscountException.new('Discount must be greater than or equal to zero')
    end
  end

  def self.validate_name(name)
    if name.length < 1
      raise InvalidNameException.new('Name should be at least 1 character long')
    end
  end

  def self.validate_email(email)
    if !email.include?('@')
      raise InvalidEmailException.new('Please supply a valid email address with a @ character')
    end
  end
end