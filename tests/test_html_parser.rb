require 'test/unit'
require 'bot/html_parser'

class HTMLParserSpec < Test::Unit::TestCase
    
    def test_selector_simple_case()
        html = %{
            <body>
              <div>
                <span>Hello</span>
              </div>
            </body>
        }
        
        parser = HTMLParser.new(html)
        
        span = parser.find_element(:span)
        
        assert_equal span.value, "Hello"
    end
    
end