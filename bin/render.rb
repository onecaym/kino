require 'haml'

module Render
	def renderfilm(movies)
	template = File.read('../lib/templates/web.haml')
	engine = Haml::Engine.new(template)
	output = engine.render(Object.new, movies: movies)
	File.write("newcol.html", output)
	end
end