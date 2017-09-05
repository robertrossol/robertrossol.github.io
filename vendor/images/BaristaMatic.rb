# BaristaMatic

@drinks = [
  {name: "coffee", ingredients: [
    {name: "coffee", amount: 3}, 
    {name: "sugar", amount: 1}, 
    {name: "cream", amount: 1}],
    in_stock: true
  },
  {name: "decaf coffee", ingredients: [
    {name: "decaf coffee", amount: 3}, 
    {name: "sugar", amount: 1}, 
    {name: "cream", amount: 1}],
    in_stock: true

  },
  {name: "caffe latte", ingredients: [
    {name: "espresso", amount: 2}, 
    {name: "steamed milk", amount: 1}],
    in_stock: true
  },
  {name: "caffe americano", ingredients: [
    {name: "espresso", amount: 3}],
    in_stock: true
  },
  {name: "caffe Mocha", ingredients: [
    {name: "espresso", amount: 1},
    {name: "cocoa", amount: 1},
    {name: "steamed milk", amount: 1},
    {name: "whipped cream", amount: 1}],
    in_stock: true
  },
  {name: "cappucino", ingredients: [
    {name: "espresso", amount: 2}, 
    {name: "steamed milk", amount: 1}, 
    {name: "foamed milk", amount: 1}],
    in_stock: true
  }
]
@drinks = @drinks.sort_by {|drink| drink[:name]}
@ingredients = [
  {name: "coffee", cost: 0.75, inventory: 10},
  {name: "decaf coffee", cost: 0.75, inventory: 10},
  {name: "sugar", cost: 0.25, inventory: 10},
  {name: "cream", cost: 0.25, inventory: 10},
  {name: "steamed milk", cost: 0.35, inventory: 10},
  {name: "foamed milk", cost: 0.35, inventory: 10},
  {name: "espresso", cost: 1.10, inventory: 10},
  {name: "cocoa", cost: 0.90, inventory: 10},
  {name: "whipped cream", cost: 1.00, inventory: 10},
]
@ingredients = @ingredients.sort_by {|ingredient| ingredient[:name]}

def menu
  puts "Menu:"
  drink_number = 0
  @drinks.each do |drink|
    cost = 0
    drink_number += 1
    drink[:ingredients].each do |drink_ingredient|
      inventory_ingredient = @ingredients.find {|ingredient| ingredient[:name] == drink_ingredient[:name]}
      cost += inventory_ingredient[:cost]*drink_ingredient[:amount]
      if drink_ingredient[:amount] > inventory_ingredient[:inventory]
        drink[:in_stock] = false
      end
    end
    puts drink_number.to_s + "." + drink[:name].capitalize + ",$" + "%.2f" % cost + "," + drink[:in_stock].to_s
  end
end

def inventory
  puts "Inventory: "
  @ingredients.each do |ingredient|
    puts ingredient[:name] + "," + ingredient[:inventory].to_s
  end
end


def order_drink(drink_number)
  if @drinks[drink_number.to_i-1][:in_stock] == false
    puts "Out of Stock: " + @drinks[drink_number.to_i-1][:name]
  else
    puts "Dispensing: " + @drinks[drink_number.to_i-1][:name].capitalize
    @drinks[drink_number.to_i-1][:ingredients].each do |drink_ingredient|
      inventory_ingredient = @ingredients.find {|ingredient| ingredient[:name] == drink_ingredient[:name]}
      inventory_ingredient[:inventory] -= drink_ingredient[:amount]
    end
  end
  inventory
  menu
end

inventory
menu

input = nil
accepts = []
@drinks.length.times do |num| 
  accepts.push((num+1).to_s)
end
accepts.push("q","Q","r","R")
while input != "q" && input != "Q"
  until accepts.include? input do
    if input == nil
      input=gets.chomp
    else
      puts "Invalid selection: " + input.to_s
      input = gets.chomp
    end
  end
  if input.to_i > 0 && input.to_i <= @drinks.length
    order_drink(input)
    input = gets.chomp
  elsif input.downcase == "r"
    @ingredients.each do |ingredient|
      ingredient[:inventory]=10
    end
    @drinks.each do |drink|
      drink[:in_stock] = true
    end
    inventory
    menu
    input = gets.chomp
  end
end