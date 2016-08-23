class InsuranceCompany
  attr_accessor :name, :received_message

  def initialize(name:)
    @name = name
    @received_message = 'no messages received'
  end
end
