require 'net/http'
require './lib/html_parser/html_parser.rb'

class HeroQuery
    def initialize(hero)
        self.set_hero(hero)
    end
    
    def set_hero(hero)
        @uri = URI(URI.encode("http://www.hotslogs.com/Sitewide/HeroDetails?Hero=#{hero}"))    
    end
    
    def send()
        @data = Net::HTTP.get(@uri)
    end
    
    def get_talent_data()
        if @data.nil?
            self.send()
        end
        
        f = open('raw', 'w')
        f.puts(@data)
        f.close()
        
        data_element = HTMLParser.parse_HTML(@data)
        
        def read_children(el)
            puts el.selector
            el.children.each do |child|
                puts child.to_s
            end
        end
        read_children(data_element)
        
        table = data_element.find_selector('table#ctl00_MainContent_RadGridHeroTalentStatistics_ctl00') # TODO: fix searching
    end
end
