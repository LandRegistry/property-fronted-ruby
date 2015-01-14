ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter
]
SimpleCov.start

require_relative 'config'
require 'rspec'
require 'test/unit'
require 'rack/test'

class HelloWorldTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_says_hello_world
    get '/hi'
    assert last_response.ok?
    assert_equal 'Hello World!', last_response.body
  end

  def test_index
    get '/'
    assert_equal last_response.status, 200
  end

=begin
  def test_title_number
    get '/property/:title_number', :title_number => 'DN1'
    assert
  end
=end
end
