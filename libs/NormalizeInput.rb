module NormalizeInput

    # to Array method
    def self.to_array(input)
        arr = input.split(/\W+|\s+/)
        arr.map! {|val| val.downcase}
        return arr
    end

    # to String method
    def self.to_string(input)
        return input.strip.downcase
    end

end