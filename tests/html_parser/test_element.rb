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
        assert_equal el.id, nil, 'Should have nil for id if has none'
    end
    
    def test_class_getters_setters()
        el = Element.new.from_string('<span class="first second">')
        
        assert_equal el.has_class?('first'), true, 'Should return true if has class'
    end
    
    def test_selector()
        el = Element.new.from_string('<div>')
        assert_equal 'div', el.selector, 'Should generate selector with tag only'
        
        el_with_class = Element.new.from_string('<span class="hello world">')
        assert_equal 'span.hello.world', el_with_class.selector, 'Should generate selector with all classes'
        
        el_with_class_and_id = Element.new.from_string('<td class="foo bar" id="cat">')
        assert_equal 'td.foo.bar#cat', el_with_class_and_id.selector, 'Should generate selector with classes and ids'
    end
    
end