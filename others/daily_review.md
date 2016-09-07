Review 18.08:

  DiR (Design is Refactoring):
>   OCP (Open/Closed Principle)
      - code is open for changes but closed for modifications
      - when adding new feature:
        1. add new method that contains the feature
        2. pass new tests
        3. delete old method that need refactoring
        4. pass tests again
      - code is never OCP all the time. It depends on the feature I want to add
      - code would never break when using OCP all tests should past in every next step

----------

Changes 19.08:

1.  method names - verbs added
3.  spec_helper added
4.  lights from CONST to variable so each instance
    can turn them independently
5.  logic for turn lights added
    (methods turn, end_turn, in_case_of_emergency end_of_emergency added)
6.  changed logic of stop_engine method to turn off all lights
7.  when car stop_engine and it is in_case_of_emergency
    turn lights won't be turned off
8.  added transmission to show_car method

----------

Review 22.08:
   > x.remainder(y) means x-y*(x/y).truncate
     (truncate = to_i, to_int; is making int from float without rounding)

  DiR (Design is Refactoring):
   > Romans and the OCP:
        - Not only introducing new logic of functionality is called refactoring.
          For example it can change only the design of the code to raise redability and understanding.
          
          "several methods do similar things but with different values contained
           in the method body. Create one method that uses a parameter for the
           different values"
           - shift_gear method example from Car class.           
   > Decoration Pattern:
        adds responsibilities to an object dynamically
        
        - pesant example
 
Changes 22.08:

1.  started to build logic for an accident occurence
2.  read Romans and the OCP article
3.  decorators

----------

Review 23.08:
>   Forwardable module allows to delegate methods to object from another class using def_delegators
    where the first parameter is an object ex. :@bed or without @ if there is method bed
    that shows @bed object.
    def_delegator can change 'method name' for given object
    - person/assignement, book/product pesant/warrior examples
      
>   freeze: it prevents object from further modifications. Object can't be unfreezed
    Immutability. Some objects in Ruby are default frozen;
    from classes: Fixnum, Bignum, Float, Symbol
      
>   .rspec
    could have some additional options shown and described at spec --h (help)
    for example we can only specific spec's that contain given string
    in whole description [describe, context, it]:
    spec --example STRING (ex. STRING = 'speed to 0')
      
  DiR (Design is Refactoring):
>   TRUE Principle:
    
    Transparent
      Everyone should know what happens when reading my code
      - proper names of classes, methods, objects etc.
    
    Resonable
      There should be a possibility to change the code with an efford
      equivalent to complexity of a change.
    
    Usable
      The code should be ready to use in other situations
      - send_message sends given message not only when having an accident
    
    Exemplary
      Our code should serve as an example for other people
    
    
     

Changes 23.08:

1.  names in_case_of_emergency && end_of_emergency changed
2.  pesant/warrior classes extended
    pesant methods available for the warrior
3.  changed transsmision int 2 to const DEFAULT_GEARS
4.  added private method to check if emergency lights are turned on
5.  added tests and implemented methods accident_occured, send_message
6.  added id and id_base to Person class
7.  read about TRUE code with example 99 beer song
8.  added notification class, specs for insurance and notification

----25.08----

Review:
>   Set class - mixin of array and hash that have unique objects.
    can be initialized using Set.new or .to_set
    adding exiting value do not raise error but values will not change anyway

  DiR (Design is Refactoring):
>   Robot, You Have One Job:

    When I describe class and I have to use "and" or "or" words it usually means that
    this class is not the subject to Single Responsibility Principle.
    Those responsibilities should be divided into another classes and then used in main class.
    Thanks to that I can faster find bugs and my code is not unnesessarly dependent on itself:
    changing one name or a value influences on many other things
    
>   Organizing Data: Replace Array with Object    

    
  Reading betterspec.org:
    - rspec matchers:
        * respond_to (with >number, keywords< arguments)
        * to_satisfy(description: be sth OR do sth) {block}

Changes:

1.  answer_message in InsuranceCompany now sets recieved message to default value
2.  redesigned whole project to send messages using Notification class
    
----29.08----

Review:

>   Single Responsiblity Principle (SRP)

Changes:

CAR REFACTORING! :)

1.  extracted show_car method to new class CarPresentation
2.  shift_gear now shifts gear and returns max speed from given range
3.  shift gear method extracted to the Gearbox class
4.  GEARS and DEFAULT consts extracted the Gearbox class
5.  IncorrectSpeedException error extracted to the Gearbox class
6.  transmission extracted to the Gearbox class

----29.08----

Review:

>   I have mastered a new method strip for String class.
    It returns copy of the string with all whitespaces
    from the beginning and the ending removed.
    
>   4 Simple Rules of Raindrops - next article form DiR blog:

    * Tests Pass - code should be always in working state with all tests passing
    * Express Intent - it should be clear what is matter when reading the code
    * No Duplication of knowledge - selfexplainable
    * Small - If I follow first three rules, the code will be small already
   

Changes:

1.  Changed gearbox variables in initialize to keyword arguments for better readability
2.  all gears logic moved to gearbox class including shift (reverse, neutral) gear methods.
3.  rzeczy po else daj do nowej linii - DONE
4.  made new class Gears that has got all gears and allows to make more gears when initialized
5.  lights_switch, and turn_all_lights_off private methods added to the Car class

----31.08----

Changes:

1.  lights_switch(state, *light) -> renamed light to lights
2.  lights_switch(..) -> changed the order of arguments
3.  lights_switch -> switch_lights renamed
4.  turn_all_lights_off renamed to turn_all_lights_off!
5.  changed gears from class to OpenStruct object
6.  keyword arguments added to the shift_gear method

----01.09----

Changes:

1.  switch_lights -> gets second argument as a keyword argument
2.  deleted show_car from Car class
    replaced CarPresentation class with Present module and
    included it to the Car class
3.  added transmission variable to the Gearbox class
    added set_transmission method to the Gearbox class
    added private method set_number_of_gears to the Gearbox class

----02.09----

Changes:

1.  public removed from classes
2.  turn_on/off_the_lamps method changed to change_lamps_state
3.  all lights logic moved to the lights class
4.  deleted default driver from Car class
5.  added spec to raise error if user gives sth else
    than 'left', 'right' in turn method

----05.09----

Changes:

1.  'turns all lamps on, when :all given as a parameter' - description in one line
2.  keyword state changed to: should_be_turned_on
3.  removed 'jake ='
4.  added a spec to #show_lamps_state method
5.  changed each -> map for show_lamps_state method
6.  dodaj metodę, która zmieni stan obiektu lamp w klasie Lampy - gotowe!

----06.09----

Changes:

-   changed spec 'creates car with lights turned off', to check if lights receive change_lamps_state method.
-   moved Lamp to lamp.rb file. Created specs for change_lamp_state method
-   deleted change_lamps_method from Lights class and modified car to use only method from Lamp class
-   deleted all unnesessary @
-   added lamps array with all lamps in Lights class
-   deleted all 'instance_variables' magic 

----07.09----

Changes:

-   added turn_on!, turn_off! method with specs to the Lamp
-   changed methods old names to those from previous point also in specs
-   added head_lamps, tail_lamps, stop_lamps, left_indicator, right_indicator methods with specs to the Car
-   changed methods old names to those from previous point also in specs
-   Używaj takiej struktury: class Lamp < Struct.new(... - gotowe
-   @lamps.map{|lamp| lamp.is_turned_on} -> lamps.each(&:is_turned_on)
-   Mógłbyś zrobić tak, że jak są lampy, to przekazujesz idiki lamp,
    które mają być wyłączone lub załączone, coś w stylu: lights.turn_on(:right_turn)
    lub lights.turn_off(:head, :tail, :brake) - gotowe
-   added spec to show_car method
-   number_of_gears = gears.to_h.size -> mógłbyś dodać takie property w klasie Gears,
    która zwróci Ci liczbę gears, bez konwertowania tego do hasha i sprawdzania długości
    deleted const and number_of_gears, added transmission as a parameter with default 5
-   added WorkWithFile class
-   added method export to WorkWithFile class with specs



TODO:
    
-   metoda, która może ladować ileś samochodów z pliku tekstowego
