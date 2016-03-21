require 'test/unit'
require 'bot/html_parser'

class HTMLParserSpec < Test::Unit::TestCase
    
    def test_selector()
        html = %{
            <body>
              <div>
                <span>Hello</span>
              </div>
            </body>
        }
        
        parser = HTMLParser.new(html)
        
        span = parser.findElement(:span)
        
        assert_equal span.element, "<span>Hello</span>"
    end
    
end