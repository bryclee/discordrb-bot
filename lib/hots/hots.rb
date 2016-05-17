require 'net/http'
require './lib/html_parser/html_parser'
require './lib/html_parser/utils'

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
        
        talent_table = data_element.find_selector('table#ctl00_MainContent_RadGridHeroTalentStatistics_ctl00') # TODO: fix searching
        
        HTMLUtils.print_el(talent_table[0])
        return talent_table
    end
end
