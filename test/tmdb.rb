require 'themoviedb'
module Kino
	Tmdb::Api.key("e05cae74c45af026ca21e22e06715c5d")
	configuration = Tmdb::Configuration.new
	url = configuration.base_url
	poster_size = configuration.poster_sizes
	@film = Tmdb::Find.imdb_id('tt0111161')
	poster_path = @film['movie_results'].map { |e| e['poster_path'] }
	p "#{url}original#{poster_path[0]}"
	# File.write("red.txt", @film['posters'])
end