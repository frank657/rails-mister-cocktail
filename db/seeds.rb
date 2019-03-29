# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'

# url = 'https://raw.githubusercontent.com/maltyeva/iba-cocktails/master/recipes.json'

# cocktails_array = JSON.parse(open(url).read)

# Dose.delete_all if Rails.env.development?
# Ingredient.delete_all if Rails.env.development?
# Cocktail.delete_all if Rails.env.development?

# cocktails_array.each do |cocktail|
#   c = Cocktail.create!(name: cocktail["name"])

#   cocktail["ingredients"].each do |ing|
#     i = Ingredient.find_or_create_by(name: ing["ingredient"])
#     unless ing['amount'].nil?
#       description = "#{ing['amount']} #{ing['unit']}"
#       d = Dose.new(description: description)
#       d.ingredient = i
#       d.cocktail = c
#       d.save
#     end
#   end
# end

# p "created #{Cocktail.count} cocktails"
# p "created #{Ingredient.count} ingredients"
# p "created #{Dose.count} doses"

# -------------------

url = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic'

cocktails_array = JSON.parse(open(url).read)

Review.delete_all if Rails.env.development?
Dose.delete_all if Rails.env.development?
Ingredient.delete_all if Rails.env.development?
Cocktail.delete_all if Rails.env.development?

cocktails_array["drinks"].each do |cocktail|
  c = Cocktail.create(name: cocktail["strDrink"])
  c.remote_photo_url = cocktail["strDrinkThumb"]
  c.save

  rand(1..20).times do
    r = Review.new(content: Faker::TvShows::GameOfThrones.quote)
    c = Cocktail.all.sample
    r.rating = rand(1..5)
    r.cocktail = c
    r.save
  end

  id = cocktail["idDrink"]
  c_url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{id}"
  c_array = JSON.parse(open(c_url).read)

  c_array["drinks"].each do |details|
    counter = 1
    until details["strIngredient#{counter}"] == ""
      i = Ingredient.find_or_create_by!(name: details["strIngredient#{counter}"])
      d = Dose.new(description: details["strMeasure#{counter}"])
      d.ingredient = i
      d.cocktail = c
      d.save
      counter += 1
    end
  end
end



p "created #{Cocktail.count} cocktails"
p "created #{Ingredient.count} ingredients"
p "created #{Dose.count} doses"
p "created #{Review.count} reviews"

