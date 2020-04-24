$LOAD_PATH.unshift 'lib'
package_name = 'theusual'
require "#{package_name}"
package = TheUsual


Gem::Specification.new do |s|
  s.name        = package_name
  s.version     = package.const_get 'VERSION'
  s.authors     = ['Daniel Pepper']
  s.summary     = package.to_s
  s.description = 'A handful of useful hacks...good for any project'
  s.homepage    = "https://github.com/dpep/rb_#{package_name}"
  s.license     = 'MIT'

  s.files       = Dir.glob('lib/**/*')
  s.test_files  = Dir.glob('test/**/test_*')

  s.add_development_dependency 'byebug'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'rake'
end
