module HTMLUtils
    module_function
    
    # Split a selector string into parents and current regexps
    def parse_selector(selector_str)
        parts = /(?<parent>.*)?(?:^|\s)(?<current>\S*)$/.match(selector_str)
        regexps = Hash.new
        
        if parts['parent'] != ''
            regexps['parent'] = selector_to_regex parts['parent']
        end
        
        regexps['current'] = selector_to_regex parts['current']
        
        return regexps
    end
    
    def selector_to_regex(str)
        Regexp.new str.gsub('.', '\.')
    end
end