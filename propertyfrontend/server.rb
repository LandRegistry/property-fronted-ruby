
def rest_get_call(url)
  uri = URI.parse(url)

  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new(uri.path + (uri.query != nil ? '?' + uri.query : ''),  initheader = {'Content-Type' =>'application/json'})
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

  if json.nil?
    raise 404
  end

  erb :body_layout, :layout => false do
    erb :lr_layout, :layout => false do
      erb :govuk_layout do
        erb :view_property, :locals => {:title => json, :apiKey => ENV['OS_API_KEY'], :service_frontend_url =>service_frontend_url}
      end
    end
  end

end

get '/search/results' do

  query =  params['search']

  search_api_url = ENV['SEARCH_API'] + '/search'
  search_url = search_api_url + '?query=' + query

  response = rest_get_call(search_url)



  result_json = JSON.parse(response)

  one_result = result_json['results'].length == 1

  erb :body_layout, :layout => false do
    erb :lr_layout, :layout => false do
      erb :govuk_layout do
        erb :search_results, :locals => {:results => result_json['results'], :query => query, :apiKey =>ENV['OS_API_KEY']}
      end
    end
  end 
end
