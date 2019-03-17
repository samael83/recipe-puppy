module HandleResponse

    # Basic handling
    def HandleResponse.error(status)
        puts "Server responded with #{status}, please retry later"
        exit(0)
    end

end