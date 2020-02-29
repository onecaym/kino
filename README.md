This is a test project for MKDEV.ME wich can generate different webpages using a lot of information from IMDB.com
## Installation
` $ gem install kino_test`
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

### Top up the balance:
`netflix.pay(20)`

### Showing user's balance:
`netflix.balance`

### Define user's filter:
`netflix.define_filter(:new_sci_fi) { |movie, year| movie.year &gt; year &amp;&amp; ... }`

### Adding parameter to user's filter:
`netflix.show(new_sci_fi: 2010)`

### Editing user's filter: 
`netflix.define_filter(:newest_sci_fi, from: :new_sci_fi, arg: 2014)`

### Showing random movie using some filters:
`netflix.show(genre: 'Comedy')`

### Getting movie's price:
`netflix.how_much?('Citizen Kane')`

### Showing all movies with selected genre using DSL:
`netflix.by_genre.comedy`

### Showing all movies with selected country using DSL:
`netflix.by_country.canada`

### Take money from the cashbox:
`netflix.take('Bank')`
___
## Theater functionality
This part of uor gem will work if we have a sheldue. You can use the standart sheldue and just change the modifications.
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
