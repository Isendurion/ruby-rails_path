Review 18.08:

DiR (Design is Refactoring):
  > OCP (Open/Closed Principle)
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
>   

Changes:

1.  #answer_message in InsuranceCompany now sets @recieved message to default value
2.  redesigned whole project to send messages using Notification class
