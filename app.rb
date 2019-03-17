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
base_url = 'http://www.recipepuppy.com/api/?i='
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
    puts "Server returned an error, retrying in 5 sec..."
    # handleError()
end

# Parse and store response as JSON object
responseHash = JSON.parse(response)

if responseHash['results'].length == 0
    puts "No matching resluts based on provided input, please check your spelling and try agian."
    exit(0)
end

# Check ingredients subroutine

# Print results
    # Recipe title
    # Recipe link