
def rest_get_call(url)
  uri = URI.parse(url)

  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new(uri.path,  initheader = {'Content-Type' =>'application/json'})
  response = http.request(request)

  return response.body
end

get '/hi' do
  "Hello World!"
end

#get index page
get '/' do
  erb :index
end

get '/property/:title_number' do

  $stdout.puts params
  title_url = ENV['SEARCH_API'] + '/titles/' + params[:title_number]

  response = rest_get_call(title_url)

  json = JSON.parse(response)

  service_frontend_url = ENV['SERVICE_FRONTEND_URL'] + '/property/'

  erb :view_property, :locals => {:title => json, :apiKey => ENV['OS_API_KEY'], :service_frontend_url =>service_frontend_url}
end

get '/search/results' do

end
