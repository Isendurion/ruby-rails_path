class Person
  def initialize(name:, insurance: liberty = InsuranceCompany.new(name: 'Liberty Insurance'))
    @name = name
    @insurance = insurance
  end
end
