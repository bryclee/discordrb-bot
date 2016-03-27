require 'test/unit'
require 'html_parser/element'

class SimpleElementSpec < Test::Unit::TestCase
    
    def test_happy_case()
        el = Element.new.from_string('<span class="Something big" id="unique">')
        
        assert_equal el.tag, 'span', 'Should parse the tag of the element'
        assert_equal el.classes, ['Something', 'big'], 'Should parse class of element'
        assert_equal el.id, 'unique', 'Should parse id of element'
        assert_equal el.content, '', 'Should initialize content with empty string'
        assert_equal el.children, [], 'Should initialize children with empty array'
    end
    
    def test_missing_optional()
        el = Element.new.from_string('<span>')
        
        assert_equal el.classes, [], 'Should have blank array for classes if has none'
        assert_equal el.id, '', 'Should have blank string for id if has none'
    end
    
    def test_class_getters_setters()
        el = Element.new.from_string('<span class="first second">')
        
        assert_equal el.has_class?('first'), true, 'Should return true if has class'
    end
end