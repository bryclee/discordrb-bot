require 'test/unit'
require 'html_parser/html_parser'

class HTMLParserSpec < Test::Unit::TestCase
    
    def test_selector_simple_case()
        html = %{
            <!doctype html>
            <html>
                <head>
                    <title>Title here</title>
                </head>
                <body>
                    <div>
                        <span>Hello</span>
                    </div>
                </body>
            </html>
        }.strip
        
        parser = HTMLParser.new(html)
        
        span = parser.find_element('span')
        
        assert_equal span[0].content, "Hello"
    end
    
    def test_selector_complex_case()
        html = %{
            <!doctype html>
            <html>
                <head>
                    <title>Hello</title>
                </head>
                <body>
                    <div class="container">
                        <span>Hello friend</span>
                        <div>
                            <span id="note">Hello 2</span>
                        </div>
                    </div>
                </body>
            </html>
        }.strip
        
        parser = HTMLParser.new(html)
        
        parser.find_element('div')
    end
    
end