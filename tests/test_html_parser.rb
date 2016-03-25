require 'test/unit'
require 'html_parser/html_parser'

class HTMLParserSpec < Test::Unit::TestCase
    
    def test_selector_simple_case()
        html = %{
            <body>
              <div>
                <span>Hello</span>
              </div>
            </body>
        }.strip
        
        parser = HTMLParser.new(html)
        
        span = parser.find_element(:span)
        
        puts 'I am the boogie man'
        puts parser
        assert_equal span.content, "Hello"
    end
    
end