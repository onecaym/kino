require 'themoviedb'
require 'dotenv/load'
module Kino
  module MovieDB
    Tmdb::Api.key(ENV['TMDBKEY'])
    def picturelink(id)
      configuration = Tmdb::Configuration.new
      url = configuration.base_url
      @film = Tmdb::Find.imdb_id(id)
      poster_path = @film['movie_results'].map { |e| e['poster_path'] }
      "#{url}w92#{poster_path[0]}"
    end

    def filmbudget(id)
      movie = Tmdb::Movie.detail(id)
      movie['budget']
    end

    def translation(id)
      Tmdb::Api.language('ru')
      Tmdb::Movie.detail(id)['title']
    end
  end
end
