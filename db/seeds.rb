# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'

url = 'https://raw.githubusercontent.com/maltyeva/iba-cocktails/master/recipes.json'

cocktails_array = JSON.parse(open(url).read)

Dose.delete_all if Rails.env.development?
Ingredient.delete_all if Rails.env.development?
Cocktail.delete_all if Rails.env.development?

cocktails_array.each do |cocktail|
  c = Cocktail.create!(name: cocktail["name"])

  cocktail["ingredients"].each do |ing|
    i = Ingredient.find_or_create_by(name: ing["ingredient"])
    unless ing['amount'].nil?
      description = "#{ing['amount']} #{ing['unit']}"
      d = Dose.new(description: description)
      d.ingredient = i
      d.cocktail = c
      d.save
    end
  end
end

p "created #{Cocktail.count} cocktails"
p "created #{Ingredient.count} ingredients"
p "created #{Dose.count} doses"


# {"name"=>"Rusty Nail", "glass"=>"old-fashioned", "category"=>"After Dinner Cocktail", "ingredients"=>[{"unit"=>"cl", "amount"=>4.5, "ingredient"=>"Whiskey", "label"=>"Scotch whisky"}, {"unit"=>"cl", "amount"=>2.5, "ingredient"=>"Drambuie"}], "garnish"=>"Lemon twist", "preparation"=>"Build into old-fashioned glass filled with ice. Stir gently."}
