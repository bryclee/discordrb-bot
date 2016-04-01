module HTMLUtils
    module_function
    
    # Parse a selector as a string into a Regexp
    def selector_to_regex(str)
        Regexp.new(str.strip.gsub('.', '\b\S*\.').gsub('#', '\b\S*#').gsub(' ', '(\b.*\s.*\b)') << '\b[^\s]*\z')
    end
end
