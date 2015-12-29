require 'uri'
class Url < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	validates :long_url, :format => { :with => /\A#{URI::regexp(['http', 'https'])}\z/}
	def shorten
		generator = SecureRandom.hex(6)
		self.update(short_url: generator.to_s)
	end
end
