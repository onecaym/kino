This is a test project for MKDEV.ME wich can generate different webpages using a lot of information from IMDB.com
## Installation
` $ gem install kino_test`
____
## Usage

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
