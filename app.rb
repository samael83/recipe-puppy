require 'httparty'
require 'json'
require './libs/NormalizeInput.rb'
require './libs/BaseURL.rb'
require './libs/HandleResponse.rb'

# Greet user and recieve input
print "\n"
puts '*' * 40, '*' * 40
puts "\tWelcome to RecipePuppy"
puts '*' * 40, '*' * 40

puts """
Here in RecipePuppy we work around the clock 
to best match what your stomach truly desires.
"""

print "\n"
puts "Today we will be making omelets."
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

    ingredients = recipe['ingredients'].split(', ')

    print "\n"
    puts "let's check if you can make #{recipe['title'].strip}"
    puts "." * 50

    ingredients.each_with_index do |ingredient, idx| # TO DO: Refactor if statements

        # Break current iteration if we know ingredient in missing ingredients
        if missing_ingredients.include? (ingredient)
            break
        end

        # Skip to next iteration if user has ingredient, unless its the last iteration
        unless idx == ingredients.length - 1
            next if user_ingredients.include? (ingredient)
        end

        print "Do you have #{ingredient}? (yes / no) > "
        answer = $stdin.gets.chomp

        # If ingredient missing > add to missing ingredients array and stop iteration
        if answer.downcase == 'no'
            missing_ingredients.push(ingredient)
            puts "\nDon't worry, Let's try another."
            break
        end

        # Add ingredient to user invetory
        if answer.downcase == 'yes'
            user_ingredients.push(ingredient)
        end
        
        # If last iteration > add current recipe to final recipes list
        if idx == ingredients.length - 1
            puts "\nYey! You can make \"#{recipe['title'].strip}\"!"
            matching_recipe.push({'Recipe' => recipe['title'].strip, 'Link' => recipe['href'].strip})
        end

    end

end

# Present possible recipes to user
if matching_recipe.length == 0
    puts "\n\nWow mate! You should really consider do some grocery shopping..."
    print "\n"
else
    puts "\n\nThere you go Sir, some tasty recipes for you to try out!"
    matching_recipe.each do |item|
        puts "Recipe: #{item['Recipe']}"
        puts "Link: #{item['Link']}"
        print "\n"
    end
end