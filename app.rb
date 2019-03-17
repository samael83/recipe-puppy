require 'httparty'
require 'json'
require './libs/NormalizeInput.rb'

# Recieve user ingredients input
print "\n"
puts '*' * 40
puts "\tWelcome to RecipePuppy"
puts '*' * 40
puts "Please specify one or more ingredients and we will match the best recipes for you!"
puts "Specify your ingredient(s) here:"
print "> "

# Globals
base_url = 'http://www.recipepuppy.com/api/?q=omelet&i='
user_input = $stdin.gets.chomp

# Normalize input 
user_ingredients = NormalizeInput.to_array(user_input)

# Init base URL for HTTP request
def initURL(base, params)
    url = base.concat(params.join(','))
    return url
end

final_url = initURL(base_url, user_ingredients)

# Send HTTP GET request
response = HTTParty.get(final_url)

if response.code != 200
    puts "Server responded with a #{response.code} error, please retry later"
    # handleError()
    exit(0)
end

# Parse JSON
responseHash = JSON.parse(response)

# Check if no results
if responseHash['results'].length == 0
    puts "We couldn't find a match to your query, please check your spelling and try agian."
    exit(0)
end

recipes = responseHash['results']

# Check ingredients subroutine

missingIng = []

recipes.each do |item|

    ingredients = item['ingredients'].split(', ')

    puts "=" * 50
    puts "let's check if you can make #{item['title'].strip}"
    puts "." * 50

    print "In order to make it you need: #{ingredients} \n" 
    print "you have: #{user_ingredients} \n" 
    print "you do not have: #{missingIng} \n" 
    
    ingredients.each do |ing|

        if missingIng.include? (ing)
            break
        end

        next if user_ingredients.include? (ing)

        print "Do you have #{ing} > "
        answer = $stdin.gets.chomp

        if answer == 'no'
            missingIng.push(ing)
            break
        end

        if answer == 'yes'
            user_ingredients.push(ing)
        end

    end

    # TO DO: Print results: title and link
    puts "You can make #{item['title'].strip}!!!"

end






