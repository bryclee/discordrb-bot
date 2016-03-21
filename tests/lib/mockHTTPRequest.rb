require 'net/http'

class MockHTTPRequest < Net::HTTP
    
    def initialize(address, port)
        # Override initialize of HTTP class
    end
    
    def self.new()
        # Override the new instance of the HTTP class
        super nil # Call with nil to return... instance of Net::HTTP class?
    end
    
    # Can I mock the get method of Net::HTTP?
    def mock(data)
        @data = data
        @originalHTTP = Net.send(:remove_const, :HTTP)
        Net.send(:const_set, :HTTP, self)
    end
    
    def done()
        Net.send(:remove_const, :HTTP)
        Net.send(:const_set, :HTTP, @originalHTTP)
    end
    
    def get(url)
        @data
    end
end
