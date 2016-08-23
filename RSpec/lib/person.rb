class Person
  attr_accessor :insurance
  attr_reader :id

  @@id_base = []

  def initialize(name:, insurance: 'no insurance')
    @id = give_id
    @name = name
    @insurance = insurance

    @@id_base << @id
  end

  private
  def give_id
    @@id_base == [] ? 1 : get_uniqe_id
  end

  def get_uniqe_id
    @@id_base.last+1
  end

  public

end
