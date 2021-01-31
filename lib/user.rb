class User
  attr_reader :name, :email
  attr_accessor :credit_limit

  def initialize(name, email, credit_limit)
    @name = name
    @email = email
    @credit_limit = credit_limit
  end
end
