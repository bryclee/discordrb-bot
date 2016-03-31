module HTMLUtils
    module_function
    
    # Parse a selector as a string into a Regexp
    def selector_to_regex(str)
        Regexp.new(str.strip.gsub(' ', '(\b.*\s.*\b)') << '\z')
    end
end
