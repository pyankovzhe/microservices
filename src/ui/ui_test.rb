ENV["APP_ENV"] = "test"

require "rubygems"
require "bundler/setup"
Bundler.require(:default)
require "./ui_app"

class UiAppTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_get_request
    get "/health"
    assert last_response.ok?
    assert_equal "OK", last_response.body
  end
end
