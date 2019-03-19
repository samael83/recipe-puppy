require 'httparty'
require 'json'
require './libs/NormalizeInput.rb'
require './libs/BaseURL.rb'
require './libs/HandleResponse.rb'

# Greet user and recieve input
puts "\n", '*' * 40, '*' * 40
puts "\tWelcome to RecipePuppy"
puts '*' * 40, '*' * 40

puts """
Here in RecipePuppy we work around the clock 
to best match what your stomach truly desires.
"""

puts "\nToday we will be making omelets."
puts "List the initial ingredients or leave blank"
print "> "

user_input = $stdin.gets.chomp

# Normalize input 
user_ingredients = NormalizeInput.to_array(user_input)

# Init base URL for HTTP request
request_url = BaseURL.init(user_ingredients)

# Send HTTP GET request and parse JSON
response = HTTParty.get(request_url)
HandleResponse.error(response.code) if response.code != 200
search_results = JSON.parse(response)

# Check ingredients subroutine
recipes = search_results['results']
missing_ingredients = []
matching_recipe = []

# Check for no matches
if recipes.length == 0
    puts "We couldn't find a match to your query, please check your spelling and try agian."
    exit(0)
end

recipes.each do |recipe|

    add_recipe = true
    required_ingredients = recipe['ingredients'].split(', ')
    current_ingredients = required_ingredients - user_ingredients

    puts "\nlet's check if you can make #{recipe['title'].strip}", '-' * 50

    if current_ingredients.empty?
        puts "\nRecipe for #{recipe['title'].strip} added."
        matching_recipe.push({'Recipe' => recipe['title'].strip, 'Link' => recipe['href'].strip})
        break
    elsif !(current_ingredients & missing_ingredients).empty?
        puts "You do not have some fo the ingredients for #{recipe['title'].strip}. Skipping..."
        next
    end

    current_ingredients.each do |ingredient|

        print "Do you have #{ingredient}? (y/n) > "
        answer = $stdin.gets.chomp

        if answer == 'y'
            user_ingredients.push(ingredient)
        elsif answer == 'n'
            missing_ingredients.push(ingredient)
            add_recipe = !add_recipe
            puts "\nSkipping #{recipe['title'].strip}..."
            break
        end

    end

    if add_recipe
        puts "\nRecipe for #{recipe['title'].strip} added."
        matching_recipe.push({'Recipe' => recipe['title'].strip, 'Link' => recipe['href'].strip})
    end

end

# Present possible recipes to user
if matching_recipe.length == 0
    puts "\n\nWow mate! You should really consider do some grocery shopping...", "\n"
else
    puts "\n\nThere you go Sir, some tasty recipes for you to try out!"
    puts '.' * 50, "\n"
    
    matching_recipe.each do |item|
        puts "Recipe: #{item['Recipe']}"
        puts "Link: #{item['Link']}", "\n"
    end
    
end