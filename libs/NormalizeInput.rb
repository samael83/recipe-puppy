module NormalizeInput

    # to Array method
    def NormalizeInput.to_array(input)
        arr = input.split(/\W+|\s+/) # not addressing digits /\W+|\d+|\s+/
        arr.map! {|val| val.downcase}
        return arr
    end

    # Check spelling
        # to do...

end