require 'net/http'
require './lib/html_parser/html_parser.rb'

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