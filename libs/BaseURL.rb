module BaseURL

    @base_url = 'http://www.recipepuppy.com/api/?q=omelet&i='

    # Init base URL
    def self.init(params)
        url = @base_url.concat(params.join(','))
        return url
    end

end