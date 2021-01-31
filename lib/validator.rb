require 'invalid_credit_limit_exception'
require 'invalid_name_exception'
require 'invalid_email_exception'
class Validator
  def self.validate_credit_limit(cred_limit)
    if cred_limit <= 0
      raise InvalidCreditLimitException.new('Credit Limit cannot be less than or equal to zero')
    end
  end

  def self.validate_user_name(name)
    if name.length < 1
      raise InvalidNameException.new('Length of username should be at least 1 character')
    end
  end

  def self.validate_email(email)
    if !email.include?('@')
      raise InvalidEmailException.new('Please supply a valid email address with a @ character')
    end
  end
end