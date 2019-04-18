def show(filtered_films)
      movie = filter(TIME.select { |daytime| daytime.cover? filtered_films }.values.first).sample
      timenow = Time.now
      start = timenow.strftime('%H:%M')
      # "Now showing: #{movie.name} (#{start} -" \
      #   "- #{(timenow + (60 * movie.time)).strftime('%H:%M')})"
    end