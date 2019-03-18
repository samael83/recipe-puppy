module HandleResponse

    # Basic handling
    def self.error(status)
        puts "Server responded with #{status}, please retry later"
        exit(0)
    end

end