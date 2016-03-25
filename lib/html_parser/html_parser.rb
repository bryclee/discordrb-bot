require './lib/html_parser/element'

class HTMLParser
    def initialize(html)
        @html = html
    end
    
    # Find element of type
    def find_element(type)
        regex = Regexp.new("<#{type}[\s>]")
        
        elements = @html.to_enum(:scan, regex).map {|m| [m, Regexp.last_match.offset(0)[0]]}
        
        elements.map do |element|
            
        end
    end
end

def parseDocument(document_string)
    index = 0
    
    while index < document_string.len
        if !defined? current && document_string[0] != '<'
            raise Exception.new('Must start with an HTML element')
        end
        
        if document_string[index] == '<'
            # If comment node (<!-- ) set index to end of comment
            if document_string[index + 1] == '!'
                close = document_string.index(/<\!\-\-.*?\-\->/, index)
                if close.nil?
                    raise Exception.new("Incomplete HTML, comment doesn't end")
                end
                index = Regexp.last_match(0)[1]
            # If close tag (</...>) set index to end of close, set pos to parent
            elsif document_string[index + 1] == '/'
                close = document_string.index(/<\/.*?>/, index)
                if (close.nil?)
                    raise Exception.new("Incomplete HTML, close tag for #{current.tag} doesn't end")
                end
                if current.parent.nil?
                    # End parsing string early if do not know what to do
                    return current
                else
                    current = current.parent
                end
                index = Regexp.last_match.offset(0)[1]
            else
                close = document_string.index(/<.*?>/, index)
                if (close.nil?)
                    raise Exception.new('Incomplete HTML')
                end
                offset = Regexp.last_match.offset(0)
                element = Element.new(document_string[offset[0], offset[1] - offset[0]])
                current.add(element)
                current = element
                index = offset[1]
            end
        else
            # If content does not belong to a thing, continue until it does?
            next_bracket = document_string.index(/</, index)
            if next_bracket.nil?
                raise Exception.new("Incomplete HTML, no close tag for #{current.tag}")
            next_bracket_position = Regexp.last_match.offset(0)
            current.content << document_string[index, next_bracket_position[0] - index]
            index = next_bracket_position[0]
        end
    end
                
    return current
end