require './lib/html_parser/element'

class HTMLParser
    def initialize(html)
        @element = parse_element(html)
    end
    
    # Find element of type
    def find_element(type)
        @element.find_element(type)
    end
end

def parse_element(raw_string)
    index = 0
    current = Element.new('document')
    document_string = raw_string.strip
    
    while index < document_string.length
        if current.nil? && document_string[0] != '<'
            raise Exception.new('Must start with an HTML element')
        end
        
        if document_string[index] == '<'
            # If comment node (<!-- ) or doctype set index to end of comment
            if document_string[index + 1] == '!'
                close = document_string.index(/<\!\-\-.*?\-\->|<\!doctype.*?>/, index)
                if close.nil?
                    raise Exception.new("Incomplete HTML, comment doesn't end")
                end
                index = Regexp.last_match.offset(0)[1]
            # If close tag (</...>) then wrap up the current element
            elsif document_string[index + 1] == '/'
                # set current to parent or return if no parent
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
                # Must be a new element, create a new element as a child
                close = document_string.index(/<.*?>/, index)
                if (close.nil?)
                    raise Exception.new('Incomplete HTML')
                end
                offset = Regexp.last_match.offset(0)
                element = Element.new.from_string(document_string[offset[0], offset[1] - offset[0]])
                if current.nil?
                    current = element
                else
                    current.add(element)
                end
                current = element
                index = offset[1]
            end
        else
            # If content does not belong to a thing, continue until it does?
            next_bracket = document_string.index(/</, index)
            if next_bracket.nil?
                raise Exception.new("Incomplete HTML, no close tag for #{current.tag}")
            end
            next_bracket_position = Regexp.last_match.offset(0)
            current.content << document_string[index, next_bracket_position[0] - index].strip
            index = next_bracket_position[0]
        end
    end
                
    return current
end
