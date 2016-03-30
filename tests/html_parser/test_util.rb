require 'test/unit'
require 'html_parser/utils'

class HTMLUtilsSpec < Test::Unit::TestCase
    def test_parse_selector_regex()
        # Should work for single
        regexps = HTMLUtils.parse_selector 'span.class'
        assert_nil regexps['parent'], 'Should not have value for parent'
        assert_equal Regexp, regexps['current'].class, 'Should return Regexp class objects'
        assert_equal (/span\.class/), regexps['current'], 'Should have current key in hash'
        
        # Should work for two or more elements
        regexps = HTMLUtils.parse_selector 'div#thing span.class'
        assert_equal Regexp, regexps['parent'].class, 'Should return parent as Regexp class object'
        assert_equal (/div#thing/), regexps['parent'], 'Should contain parent Regexp if longer than one element'
        assert_equal (/span\.class/), regexps['current'], 'Should still return current Regexp if longer than one element'
    end
    
    def test_selector_to_regex()
        res = HTMLUtils.selector_to_regex 'test.sentence'
        assert_match res, 'test.sentence', 'Should produce a match for period'
        assert_no_match res, 'testasentence', 'Should not match any char'
    end
end