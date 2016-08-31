class Car
  ClutchNotPressedError = Class.new(StandardError)
  CaseOfEmergencyException = Class.new(StandardError)
  NoInsuranceError = Class.new(StandardError)
  KeywordRequiredError = Class.new(StandardError)

  attr_accessor :speed, :gear, :clutch, :lights, :received_message
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
    @received_message = ''
    @is_keyword_required = is_keyword_required
  end

  private
  def emergency_lights_turned_on?
    @lights[:left_turn] && @lights[:left_turn]
  end

  def switch_lights(*lights, state)
    lights.each{|lamp| @lights[lamp] = state}
  end

  def turn_all_lights_off!
    switch_lights(:head, :tail, :brake, :left_turn, :right_turn, false)
  end

  public
  def show_car
    default_gears_quantity = 2
    all_gears_quantity = @gearbox.gears.to_h.size
    transmission = all_gears_quantity - default_gears_quantity

    CarPresentation.new(@name, @brand, @model, transmission).show_car
  end

  def start_engine
    if @clutch
      @speed = 0
      switch_lights(:head, true)
    else
      raise ClutchNotPressedError, 'Clutch is not pressed'
    end
  end

  def stop_engine
    @speed = 0
    if emergency_lights_turned_on?
      switch_lights(:head, :tail, :brake, false)
      switch_lights(:left_turn, :right_turn, true)
    else
      turn_all_lights_off!
    end
  end

  def turn(direction)
    switch_lights("#{direction}_turn".to_sym, true)
  end

  def end_turn
    if emergency_lights_turned_on?
      raise CaseOfEmergencyException, 'Warning! Hazard on the road. Do not turn emergency lights off!'
    else
      switch_lights(:left_turn, :right_turn, false)
    end
  end

  def hit_the_brakes(new_speed)
    switch_lights(:brake, true)
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
