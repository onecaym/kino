require 'themoviedb'
require 'dotenv/load'
require 'nokogiri'
module Kino
  module MovieDB
    Tmdb::Api.key(ENV['TMDBKEY'])
    def picturelink(id)
      configuration = Tmdb::Configuration.new
      url = configuration.base_url
      @film = Tmdb::Find.imdb_id(id)
      poster_path = @film['movie_results'].first['poster_path']
      "#{url}w92#{poster_path}"
    end

    def filmbudget(link)
      page = Nokogiri::HTML(open(link))
      budget = page.at('div.txt-block:contains("Budget:")')
      return if budget.nil?
      budget.text.strip.sub(/Budget:(.*) \(estimated\)/, '\1')
    end

    def translation(id)
      Tmdb::Api.language('ru')
      Tmdb::Movie.detail(id)['title']
    end
  end
end
