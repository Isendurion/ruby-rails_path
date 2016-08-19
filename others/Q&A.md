Questions:

1. require - how to write path (only name of a file, '../name', etc.)

2. expectations = {head: false, tail: false, brake: false, left_turn: false, right_turn: false}
   expect(peugeot207.lights).to eq expectations
   
   Why can't be:
   expect(peugeot207.lights).to eq {head: false, tail: false, brake: false, left_turn: false, right_turn: false}
