$LOAD_PATH.unshift 'lib'
package_name = 'theusual'
require "#{package_name}"
package = const_get package_name.capitalize


Gem::Specification.new do |s|
  s.name        = package_name
  s.version     = package.const_get 'VERSION'
  s.authors     = ['Daniel Pepper']
  s.summary     = package.to_s
  s.description = File.read('README.md')
  s.homepage    = "https://github.com/d1hotpep/#{package_name}rb"
  s.license     = 'MIT'

  s.files       = Dir.glob('lib/**/*')
  s.test_files  = Dir.glob('test/**/test_*')
  s.add_development_dependency "rake"
end
