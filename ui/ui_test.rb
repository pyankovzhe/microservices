ENV["APP_ENV"] = "test"

require "./ui_app"
require "test/unit"
require "rack/test"

class UiAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    UiApp
  end

  def test_get_request
    get "/health"
    assert last_response.ok?
    assert_equal "OK", last_response.body
  end
end
