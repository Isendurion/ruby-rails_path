module Present
  def show_car
    puts "Name: #{self.name}\nBrand: #{self.brand}\nModel: #{self.model}\nTransmission: #{self.gearbox.set_transmission}-speed\n"
  end
end

class Car
  include(Present)

  ClutchNotPressedError = Class.new(StandardError)
  CaseOfEmergencyException = Class.new(StandardError)
  NoInsuranceError = Class.new(StandardError)
  KeywordRequiredError = Class.new(StandardError)

  attr_accessor :speed, :gear, :clutch, :lights, :llights, :received_message, :name, :brand, :model
  attr_reader :is_keyword_required, :gearbox

  def initialize(name:, brand:, model:, driver: Person.new(name: 'Robert'), is_keyword_required: false)
    @name = name
    @brand = brand
    @model = model
    @driver = driver
    @speed = 0
    @clutch = false
    @gearbox = Gearbox.new
    @lights = {head: false, tail: false, brake: false, left_turn: false, right_turn: false}
    @llights = Lights.new
    @received_message = ''
    @is_keyword_required = is_keyword_required
  end

  private
  def emergency_lights_turned_on?
    @lights[:left_turn] && @lights[:left_turn]
  end

  def switch_lights(*lights, are_turned_on:)
    lights.each{|lamp| @lights[lamp] = are_turned_on}
  end

  def turn_all_lights_off!
    switch_lights(:head, :tail, :brake, :left_turn, :right_turn, are_turned_on: false)
  end

  public
  def start_engine
    if @clutch
      @speed = 0
      @llights.turn_on_the_lamps(@llights.head)
    else
      raise ClutchNotPressedError, 'Clutch is not pressed'
    end
  end

  def stop_engine
    @speed = 0
    if emergency_lights_turned_on?
      switch_lights(:head, :tail, :brake, are_turned_on: false)
      switch_lights(:left_turn, :right_turn, are_turned_on: true)
    else
      turn_all_lights_off!
    end
  end

  def turn(direction)
    switch_lights("#{direction}_turn".to_sym, are_turned_on: true)
  end

  def end_turn
    if emergency_lights_turned_on?
      raise CaseOfEmergencyException, 'Warning! Hazard on the road. Do not turn emergency lights off!'
    else
      switch_lights(:left_turn, :right_turn, are_turned_on: false)
    end
  end

  def hit_the_brakes(new_speed)
    switch_lights(:brake, are_turned_on: true)
    @speed = new_speed
  end

  def release_brakes
    @lights[:brake] = false
  end

  def turn_on_the_tail_lights
    @lights[:tail] = true
  end

  def turn_off_the_tail_lights
    @lights[:tail] = false
  end

  def send_notification(recipient, message, keyword = '')
    if recipient.is_keyword_required && keyword == ''
      raise KeywordRequiredError, 'Keyword required. Sending aborted'
    else
      recipient.received_message = Notification.new(self, recipient, "#{message}.#{keyword}")
    end
  end

  def accident_occured
    if @driver.insurance != 'no insurance'
      recipient = @driver.insurance
      message = 'Accident occured. Send car carrier'
      keyword = @driver.insurance.notification_keywords[:accident]
      send_notification(recipient, message, keyword)
      @driver.insurance.answer_message(@driver)
    else
      raise NoInsuranceError, 'You do not have an insurance. Message sending aborted'
    end
  end
end

