require 'test/unit'
require 'html_parser/html_parser'

class HTMLParserSpec < Test::Unit::TestCase
    def setup()
        html = %{
            <!doctype html>
            <html>
                <head>
                    <title>Hello</title>
                </head>
                <body>
                    <h1>Hello</h1>
                    <div class="top">
                        <span id="unique">Direct child selector</span>
                        <div class="generic child">
                            <p>Child selector</p>
                            <span class="deep" id="deep">Deepest selector</span>
                        </div>
                    </div>
                </body>
            </html>
        }
        @parser = HTMLParser.new(html)
    end
    
    def test_selector_simple_case()
        h1s = @parser.find_element('h1')
        assert_equal h1s[0].content, "Hello"
    end
    
    def test_selector_complex_case()
        divs = @parser.find_element('div')
        assert_equal 2, divs.length
        
        spans = divs.map {|div| div.find_element('span')}.flatten.to_set # Remove duplicates
        assert_equal 2, spans.length
    end
    
    def test_selector_single()
        h1s = @parser.apply_selector('h1')
        assert_equal 1, h1s.length
        assert_equal 'Hello', h1s[0].content
        
        classes = @parser.apply_selector('.deep')
        assert_equal 1, classes.length
        assert_equal 'Deepest selector', classes[0].content
        
        ids = @parser.apply_selector('#unique')
        assert_equal 1, ids.length
        assert_equal 'Direct child selector', ids[0].content
    end
end