Gem::Specification.new do |my_gem|
  my_gem.files = Dir['{bin,lib,test,spec}/**/*']
  my_gem.name = 'kino'
  my_gem.summary = 'Educational project'
  my_gem.version = '0.1'
  my_gem.author = 'Konstantin Osipov'
  my_gem.email = 'bbbggg@gmail.com'
  my_gem.executables << 'exe.rb'
  my_gem.post_install_message = 'big thanks.'
  my_gem.homepage = 'https://github.com/onecaym'
end
