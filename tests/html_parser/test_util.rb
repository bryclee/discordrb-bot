require 'test/unit'
require 'html_parser/utils'

class HTMLUtilsSpec < Test::Unit::TestCase
    def test_selector_to_regex()
        regex = HTMLUtils.selector_to_regex 'div'
        
        assert_equal Regexp, regex.class, 'Should return a Regexp'
        assert_match regex, 'div', 'Should match a lone span'
        assert_no_match regex, 'div span', 'Should only match current element'
        
        regex_parent = HTMLUtils.selector_to_regex 'span'
        assert_match regex_parent, 'div span', 'Should match with unrelated parent'
        
        regex_class = HTMLUtils.selector_to_regex 'div.class'
        assert_match regex_class, 'div.class', 'Should match div with class'
        assert_no_match regex_class, 'div', 'Should not match div without class'
        
        regex_long_parent = HTMLUtils.selector_to_regex 'div.ider span.dex'
        assert_match regex_long_parent, 'li.thium div.ider p#arent span.dex'
        assert_no_match regex_long_parent, 'div.ider#span.dex', 'Should not match without space between elements'
    end
end