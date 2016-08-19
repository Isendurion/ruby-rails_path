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
