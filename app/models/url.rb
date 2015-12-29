class Url < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	def shorten
		generator = SecureRandom.hex(6)
		self.update(short_url: generator.to_s)
	end
end
