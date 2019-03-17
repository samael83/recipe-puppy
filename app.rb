require 'httparty'
require 'json'
require './libs/NormalizeInput.rb'
require './libs/BaseURL.rb'

# Globals
base_url = 'http://www.recipepuppy.com/api/?q=omelet&i='

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
puts "Today we will be doing omelets."
puts "List the initial ingredients or leave blank"
print "> "

user_input = $stdin.gets.chomp

# Normalize input 
user_ingredients = NormalizeInput.to_array(user_input)

# Init base URL for HTTP request
request_url = BaseURL.init(base_url, user_ingredients)

# Send HTTP GET request and parse JSON
response = HTTParty.get(request_url)

if response.code != 200
    puts "Server responded with #{response.code} error, please retry later"
    # TO DO: handleError()
    exit(0)
end

search_results = JSON.parse(response)

# Check if no results
if search_results['results'].length == 0
    puts "We couldn't find a match to your query, please check your spelling and try agian."
    exit(0)
end

# Check ingredients subroutine
recipes = search_results['results']
missing_ingredients = []
matching_recipe = []

recipes.each do |recipe|

    ingredients = recipe['ingredients'].split(', ')

    print "\n"
    puts "let's check if you can make #{recipe['title'].strip}"
    puts "." * 50

    puts "Required ingredients: #{ingredients.join(', ')}" 
    puts "Your ingredients: #{user_ingredients.join(', ')}" 
    puts "Missing ingredients: #{missing_ingredients.join(', ')}" 
    
    ingredients.each_with_index do |ingredient, idx|

        if missing_ingredients.include? (ingredient)
            break
        end

        next if user_ingredients.include? (ingredient)

        print "Do you have #{ingredient}? (yes / no) > "
        answer = $stdin.gets.chomp

        if answer == 'no'
            missing_ingredients.push(ingredient)
            puts "\nDon't worry, Let's try another."
            break
        end

        if answer == 'yes'
            user_ingredients.push(ingredient)
        end
        
        if idx == ingredients.length - 1
            puts "\nYou can make \"#{recipe['title'].strip}\"!"
            matching_recipe.push({'Recipe' => recipe['title'].strip})
        end

    end

end

puts matching_recipe





