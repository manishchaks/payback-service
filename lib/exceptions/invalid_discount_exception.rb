class InvalidDiscountException < StandardError
  def initialize(msg, exception_type='custom')
    @exception_type = exception_type
    super(msg)
  end
end