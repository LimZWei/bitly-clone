get '/' do
  erb :"static/index"
end

post '/urls' do
	if params['long_url'].include?('http://localhost:9393')
	
		redirect to '/#{params["long_url"]}'
	end

	url = Url.new(long_url: params['long_url'])
	url.shorten
	redirect to "/url/#{url.id}"
end

get '/url/:url_id' do
	@url = Url.find(params[:url_id])
	erb :"static/index2"
end

get '/:short_url' do
	@original = Url.find_by(short_url: params[:short_url]).long_url
	redirect @original
end
