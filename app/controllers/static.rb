
get '/' do

	unless params[:error].nil?
		@error = params[:error]
	end
  	erb :"static/index"
end

post '/urls' do
	if params['long_url'].include?('http://localhost:9393')
		
		redirect to '/#{params["long_url"]}'
	end
	
	url = Url.new(long_url: params['long_url'])
	if url.save
		url.shorten
		redirect to "/url/#{url.id}"
	else
		redirect "/?error=invalid url"
	end
end

get '/url/:url_id' do
	@url = Url.find(params[:url_id])
	erb :"static/index2"
end

get '/:short_url' do
	@url = Url.find_by(short_url: params[:short_url])

	@original = @url.long_url
	
	@click = @url.click_count + 1
	
	@url.update(click_count: @click)
	
	redirect @original

end
