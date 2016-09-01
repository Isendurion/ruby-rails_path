Questions:

1.  'presents seat_ibiza name, brand and model'
     mógłbyś pomyśleć nad zastubowaniem metody #show_car,
     aby nie duplikować testów dla tej samej logiki
     w dwóch miejscach:
     
     # using any_instance_of
     allow_any_instance_of(CarPresentation).to receive(:show_car).and_return('description for the car')
     peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
     expect(peugeot207.show_car).to eq 'description for the car'
     # or create a double object:
     car_presentation = double('car_presentation', show_car: 'description for the car')
     allow(CarPresentation).to receive(:new).and_return(car_presentation)
     peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207')
     expect(peugeot207.show_car).to eq 'description for the car'
