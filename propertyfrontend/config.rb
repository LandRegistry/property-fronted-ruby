require 'sinatra'

set :bind, '0.0.0.0'
puts ENV['port']
set :port, (ARGV[0] || '4567')


require_relative 'server.rb'
