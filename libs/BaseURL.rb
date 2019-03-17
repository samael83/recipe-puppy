module BaseURL

    # Init base URL
    def BaseURL.init(base, params)
        url = base.concat(params.join(','))
        return url
    end

end