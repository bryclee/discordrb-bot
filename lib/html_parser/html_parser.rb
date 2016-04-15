require './lib/html_parser/element'
require './lib/html_parser/utils'

module HTMLParser
    module_function
    
    # Parse an HTML string into an Element
    def parse_HTML(raw_string)
        index = 0
        current = Element.new('document')
        document_string = raw_string.strip
        padding = ''
        
        while index < document_string.length
            if current.nil? && document_string[0] != '<'
                raise 'Must start with an HTML element'
            end
            
            if document_string[index] == '<'
                # For script elements, ignore any < brackets if it isn't a close tag for the script
                if current.tag == 'script' and /<\/script>/ !~ document_string[index, 9]
                    current.content << document_string[index]
                    index += 1
                # If comment node (<!-- ) or doctype set index to end of comment
                elsif document_string[index + 1, 3] == '!--'
                    close = document_string.index(/<\!\-\-.*?\-\->|<\!doctype.*?>/, index)
                    if close.nil?
                        log document_string[index..-1]
                        raise "Incomplete HTML, comment doesn't end"
                    end
                    index = Regexp.last_match.offset(0)[1]
                # If close tag (</...>) then wrap up the current element
                elsif document_string[index + 1] == '/'
                    # set current to parent or return if no parent
                    close = document_string.index(/<\/.*?>/, index)
                    if (close.nil?)
                        raise "Incomplete HTML, close tag for #{current.tag} doesn't end"
                    end
                    if current.parent.nil?
                        # End parsing string early if do not know what to do
                        return current
                    else
                        log "#{padding}#{current.parent.selector} < #{current.selector}"
                        padding = padding[0...-1]
                        current = current.parent
                    end
                    index = Regexp.last_match.offset(0)[1]
                else
                    # Must be a new element, create a new element as a child
                    close = document_string.index(/<.*?>/, index)
                    if (close.nil?)
                        log document_string[index..-1]
                        raise 'Incomplete HTML'
                    end
                    offset = Regexp.last_match.offset(0)
                    
                    el_str = document_string[offset[0], offset[1] - offset[0]]
                    element = Element.new.from_string(el_str)
                    
                    if current.nil?
                        current = element
                    else
                        current.add(element)
                    end
                    if el_str[-2] != '/'
                        log "#{padding}#{current.selector} > #{element.selector}" # LOGGING
                        padding = padding + ' ' # LOGGING
                        current = element
                    else
                        log "#{padding}#{current.selector} - #{element.selector}" # PURELY LOGGING
                    end
                    index = offset[1]
                end
            else
                # If content does not belong to a thing, continue until it does?
                next_bracket = document_string.index(/</, index)
                if next_bracket.nil?
                    raise "Incomplete HTML, no close tag for #{current.tag}"
                end
                next_bracket_position = Regexp.last_match.offset(0)
                current.content << document_string[index, next_bracket_position[0] - index].strip
                index = next_bracket_position[0]
            end
        end
        
        log 'return end'
        return current
    end

end

def log(str)
    HTMLUtils.log(str)
end
