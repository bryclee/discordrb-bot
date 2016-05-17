module HTMLUtils
    module_function
    
    @log_file = open('log', 'w')
    
    # Parse a selector as a string into a Regexp
    def selector_to_regex(str)
        Regexp.new(str.strip.gsub('.', '\b\S*\.').gsub('#', '\b\S*#').gsub(' ', '(\b.*\s.*\b)') << '\b[^\s]*\z')
    end
    
    def log(str)
        puts str
        @log_file.puts(str)
    end
    
    # Print an element
    def print_el(el, padding = '')
        self.log "#{padding}|#{el.selector}|#{el.content}"
        el.children.each do |child|
            print_el(child, padding + '*')
        end
    end
end

