module NormalizeInput

    # to Array method
    def self.to_array(input)
        arr = input.split(/\W+|\s+/)
        arr.map! {|val| val.downcase}
        return arr
    end

    # get first char from input
    def self.first_char(input)
        return input.strip.downcase[0]
    end

end