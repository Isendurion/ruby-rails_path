class Person
  attr_accessor :name, :insurance, :received_message
  attr_reader :id

  @@id_base = []

  def initialize(name:, insurance: 'no insurance')
    @id = give_id
    @name = name
    @insurance = insurance
    @received_message = ''

    @@id_base << @id
  end

  private
  def give_id
    @@id_base == [] ? 1 : get_uniqe_id
  end

  def get_uniqe_id
    @@id_base.last+1
  end
end
