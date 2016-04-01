require 'test/unit'
require './tests/lib/mockHTTPRequest'

class MockHTTPRequestSpec < Test::Unit::TestCase

    def test_mock()
        original_get = Net::HTTP.method :get
        mock_data = 'response'
        uri = URI('www.google.com')
        
        http_mock = MockHTTPRequest.new
        http_mock.mock(mock_data)
        
        assert_equal mock_data, Net::HTTP.get(uri), 'should respond with mock data for GET'
        
        http_mock.done()
        
        assert_equal original_get, Net::HTTP.method(:get), 'should reset original "get" method'
    end
end