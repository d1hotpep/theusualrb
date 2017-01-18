require_relative 'theusual/array.rb'
require_relative 'theusual/hash.rb'


module TheUsual
  VERSION = '0.0.1'

  def self.load *modules
    paths = {
      'ipaddr' => 'ipaddr',
      'mongoid' => 'mongoid',
      'net/ssh' => 'ssh',
    }

    modules.flatten.each do |_module|
      raise ArgumentException unless paths.has_key? _module

      require _module.to_s
      require_relative "theusual/#{paths[_module.to_s]}.rb"
    end
  end
end
