require 'sinatra'
require 'json'
require 'net/http'

set :bind, '0.0.0.0'
puts ENV['port']
set :port, (ARGV[0] || '4567')

set :public_folder, File.dirname(__FILE__) + '/public'

require_relative 'server.rb'
