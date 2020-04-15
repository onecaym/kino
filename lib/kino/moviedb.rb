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
      page = Nokogiri::HTML(open(link)) # rubocop:disable Security/Open
      budget = page.at('div.txt-block:contains("Budget:")')
      return if budget.nil?

      cleanbudget = budget.text.strip.sub(/Budget:(.*) \(estimated\)/, '\1')
      cleanbudget.delete('^0-9').to_i
    end

    def translation(id)
      Tmdb::Api.language('ru')
      Tmdb::Movie.detail(id)['title']
    end
  end
end
