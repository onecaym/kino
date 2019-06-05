require 'themoviedb'
module Kino
	module MovieDB
		Tmdb::Api.key("e05cae74c45af026ca21e22e06715c5d")
		def picturelink(id)
			Tmdb::Api.key("e05cae74c45af026ca21e22e06715c5d")
			configuration = Tmdb::Configuration.new
			url = configuration.base_url
			poster_size = configuration.poster_sizes
			@film = Tmdb::Find.imdb_id(id)
			poster_path = @film['movie_results'].map { |e| e['poster_path'] }
			"#{url}w92#{poster_path[0]}"
		end

		def filmbudget(id)
			movie = Tmdb::Movie.detail(id)
			movie['budget']
		end
	end
end