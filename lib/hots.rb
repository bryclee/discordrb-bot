require 'net/http'
require_relative './HTMLqueries.rb'

class Query
    def initialize(uri, method = 'GET')
        @uri = URI(uri)
    end
    
    def send()
        @data = Net::HTTP.get(@uri)
    end
end

hots = Query.new('http://www.hotslogs.com/Sitewide/HeroDetails?Hero=Nova')
data = hots.send()