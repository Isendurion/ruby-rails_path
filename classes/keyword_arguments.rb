# kilka przykładów dlaczego warto używac keyword arguments:

# widzimy znaczenie zmiennych bez patrzenia w cialo metody

def sale(shop:, product:, price:, days_limit:, discount:)
  puts "Sale in #{shop}! Limited to #{days_limit} days"
  puts "#{product}: price before #{price} zł | price now: #{(price *= discount/100.0).to_i} zł !!!"
end

sale(product: "Jeans", shop: "House", price: 120, discount: 40, days_limit: 14) # kolejnosc nie ma znaczenia
