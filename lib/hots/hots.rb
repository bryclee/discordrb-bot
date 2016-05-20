require 'net/http'
require './lib/html_parser/html_parser'
require './lib/html_parser/utils'

COLUMN_NAMES = [
    'TalentTier',
    'Talent',
    'Talent Description',
    'Win Percent',
    'Games Played'
]
GROUP_BY = 'TalentTier'
NEWLINE = "\r\n"

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
        
        assert 1, talent_table.length, 'Should have 1 talent table'
        
        talent_table = talent_table[0]
        headers = talent_table.find_selector('thead th.rgHeader')
        columns = {
            'TalentTier' => nil,
            'Talent' => nil,
            'Talent Description' => nil,
            'Games Played' => nil,
            'Popularity' => nil,
            'Win Percent' => nil
        }
        
        headers.each_with_index do |col, index|
            if columns.key? col.content
                columns[col.content] = index
            end
        end
        
        # Check that all columns are found
        columns.each do |key, value|
            assert false, value.nil?, "Column missing: #{key}"
        end
        
        num_columns = columns.keys.length
        rows = talent_table.find_selector('tbody tr')
        results = rows.inject([]) do |acc, row|
            if row.children.length < num_columns
                next acc
            end
            
            talent_info = columns.keys.each_with_object({}) do |key, info|
                info[key] = row.children[columns[key]].content
            end
            
            acc.push(talent_info)
        end
        
        # HTMLUtils.print_el(talent_table)
        return results
    end
    
    def get_talent_data_by_level()
        talents = self.get_talent_data()
        
        grouped_talents = talents.each_with_object(Hash.new {|hash, key| hash[key] = []}) do |row, memo|
            memo[row[GROUP_BY]].push(self.format_talent_string(row))
        end
        
        return grouped_talents
    end
    
    def get_top_talent_data_by_level()
        talents = self.get_talent_data()
        
        top = 'Win Percent'
        
        top_talents = talents.each_with_object(Hash.new {|hash, key| hash[key] = {}}) do |row, memo|
            if memo[row[GROUP_BY]][top].nil? || row[top] > memo[row[GROUP_BY]][top]
                memo[row[GROUP_BY]] = row
            end
        end
        
        return top_talents.each do |key, val|
            top_talents[key] = self.format_talent_string(val)
        end
    end
    
    def format_talent_string(talent_info)
        COLUMN_NAMES.map {|name| talent_info[name]}.join('** - ')
    end
    
    def join_message(arr)
        arr.join(NEWLINE)
    end
end

def assert(expected, actual, message)
    if expected != actual
        raise message
    end
end
