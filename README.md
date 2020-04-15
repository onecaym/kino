This is a test project for MKDEV.ME wich can generate different webpages using a lot of information from IMDB.com
## Installation
` $ gem install kino`
____
## Basic usage

### Creating collection:
`Kino::MovieCollection.new('movie.txt')`

### Filtering colletcion:
`Kino::MovieCollection.new('movie.txt').filter(country: 'Japan', period: :modern)`

### Show all movies from your collection:
`Kino::MovieCollection.new('movie.txt').all`

### Returns statistics by any parameter:
`Kino::MovieCollection.new('movie.txt').stats(:director)`

### You can sort by something
`Kino::MovieCollection.new('movie.txt').sort_by(:year)`  
___
## Netflix functionality
First we need to create the **Netflix** variable.

`netflix = Kino::Netflix.new('movie.txt')`

### Add money to your balance:
`netflix.pay(200)`

### Defines user's filter:
`netflix.define_filter(:oldest) {|movie,year| movie.year < year}`
### Shows your balance:
`netflix.balance`

### Add parameter to your filter:
`netflix.show(oldest: 1922)`

### Show random movie:
`netflix.show(genre: 'Comedy')`

### SHow movie's price:
`netflix.how_much?('The Shawshank Redemption')`
### Take money from the cashbox:
`netflix.take('Bank')`
### Showing all selected movies chosen by genre with DSL:
`netflix.by_genre.comedy`

### Showing all selected movies chosen by country with DSL:
`netflix.by_country.canada`
___
## Theater functionality
This part of our gem will work if we have a sheldue. You can use the standart sheldue and just change the modifications.
___
`theater = Kino::Theater.new('../lib/data/movies.txt') do
    hall :red, title: 'Красный зал', places: 100
    hall :blue, title: 'Синий зал', places: 50
    hall :green, title: 'Зелёный зал (deluxe)', places: 12`

    period '09:00'..'11:00' do
      description 'Утренний сеанс'
      filters genre: 'Comedy', year: 1900..1980
      price 10
      hall :green
    end

    period '11:00'..'16:00' do
      description 'Спецпоказ'
      title 'The Terminator'
      price 50
      hall :green
    end

    period '16:00'..'20:00' do
      description 'Вечерний сеанс'
      filters genre: ['Action', 'Drama'], year: 2007..Time.now.year
      price 20
      hall :green
    end

    period '19:00'..'22:00' do
      description 'Вечерний сеанс для киноманов'
      filters year: 1900..1945, exclude_country: 'USA'
      price 30
      hall :green
    end
`end`
___
### Check out the validation of sheldue
`theater.valid?`

### When does theater show a movie you want:
`theater.when?('The Shawshank Redemption')`

### Show random movie in selected period:
`theater.show('18:00')`
### Buy ticket:
`theater.buy_ticket('Citizen Kane')`

___
## Using API and rendering

`collection = MovieCollection.new('movies.txt')`

### Initializing downloader
`tmdb_downloader = Kino::Renderer.new(collection)`

### Check info in yamllib:
`yaml_lib = File.open('../lib/data/libs.yaml')`

### Write all information to YAML file:
`tmdb_downloader.write('./tmdb_info')`

### Initializing downloader
`loader = Kino::Downloader.new(collection)`

### Start render:
Everything will be automaticly uploaded if you don't have enough info for rendering. After that render will start automicly
`ruby render.rb`
___
