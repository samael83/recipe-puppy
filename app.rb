require 'httparty'
require 'json'
require './libs/NormalizeInput.rb'

# Globals
base_url = 'http://www.recipepuppy.com/api/?i='

# Recieve user ingredients input
print "\n"
puts '*' * 23
puts "Welcome to RecipePuppy."
puts '*' * 23
puts "Please specify one or more ingredients and we will match the best recipes for you!"
puts "Specify your ingredient here:"
print "> "

user_input = $stdin.gets.chomp

# Normalize input 
user_ingredients = NormalizeInput.to_array(user_input)

# Init base URL for HTTP request

# Send HTTP GET request
    # if errors => handle errors

# Parse and store response as JSON object
    # handle no results found

# Check ingredients subroutine

# Print results
    # Recipe title
    # Recipe link
