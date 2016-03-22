class HTMLParser
    def initialize(html)
        @html = html
    end
    
    # Find element of type
    def find_element(type)
        regex = Regexp.new("<#{type}[\s>]")
        
        elements = @html.to_enum(:scan, regex).map {|m| [m, Regexp.last_match.offset(0)[0]]}
        puts elements
    end
end
