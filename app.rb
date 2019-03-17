require 'httparty'
require 'json'
require './libs/NormalizeInput.rb'

# Recieve user ingredients input
print "\n"
puts '*' * 23
puts "Welcome to RecipePuppy."
puts '*' * 23
puts "Please specify one or more ingredients and we will match the best recipes for you!"
puts "Specify your ingredient here:"
print "> "

# Globals
base_url = 'http://www.recipepuppy.com/api/?i='
user_input = $stdin.gets.chomp

# Normalize input 
user_ingredients = NormalizeInput.to_array(user_input)

# Init base URL for HTTP request
def initURL(url, arr)
    str = url + arr.join(',')
    return str
end
final_url = initURL(base_url, user_ingredients)

# Send HTTP GET request
    # if errors => handle errors

# Parse and store response as JSON object
    # handle no results found

# Check ingredients subroutine

# Print results
    # Recipe title
    # Recipe link
