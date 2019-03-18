module BaseURL

    # Init base URL
    def self.init(base, params)
        url = base.concat(params.join(','))
        return url
    end

end