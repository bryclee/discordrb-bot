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
        @parser = HTMLParser.parse_HTML(html)
    end
    
    def test_parser_self_closing_elements()
        self_closing_html = %{
            <head>
                <link style="blah" />
                <span>Should be sibling</span>
            </head>
        }
        
        parser = HTMLParser.parse_HTML(self_closing_html)
        link = parser.find_selector('link')
        
        assert_equal 'link', link.tag
        assert_equal 0, link.children.length
    end
    
    def test_parser_script()
        script_html = %{
            <body>
                <script type="text/javascript">
                    if (3 < 5) {
                        console.log('stuff');
                    } else if (3 > 2) {
                        console.log('other stuff');
                    }
                </script>
                <div>Should be sibling</div>
            </body
        }
        
        parser = HTMLParser.parse_HTML(script_html)
        script = parser.find_selector('script')
        
        assert_equal 'script', script.tag
        assert_equal 0, script.children
    end
    
    def test_selector()
        h1s = @parser.find_selector('h1')
        
        assert_equal Array, h1s.class
        assert_equal 1, h1s.length
        assert_equal 'Hello', h1s[0].content
        
        classes = @parser.find_selector('.deep')
        assert_equal 1, classes.length
        assert_equal 'Deepest selector', classes[0].content
        
        ids = @parser.find_selector('#unique')
        assert_equal 1, ids.length
        assert_equal 'Direct child selector', ids[0].content
        
        nested_unique = @parser.find_selector('div.top #unique')
        assert_equal 1, nested_unique.length
        assert_equal 'Direct child selector', nested_unique[0].content
        
        misspelled = @parser.find_selector('di p')
        assert_equal 0, misspelled.length, 'Should not select if not all requirements met'
        
        select_multiple = @parser.find_selector('div')
        assert_equal 2, select_multiple.length, 'Should select more than one'
        
        select_id = @parser.find_selector('span#deep')
        assert_equal 1, select_id.length, 'Should select with tag and id'
    end
end
