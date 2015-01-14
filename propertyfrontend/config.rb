require 'sinatra'
require 'json'

set :bind, '0.0.0.0'
puts ENV['port']
set :port, (ARGV[0] || '4567')

set :public_folder, 'public'

require_relative 'server.rb'
