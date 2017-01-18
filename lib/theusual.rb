module TheUsual
  VERSION = '0.0.1'

  MODULES = [
    'array',
    'hash',
    'ipaddr',
    'mongoid',
    'net/ssh',
    'time',
  ]

  def self.load *modules
    needs_load = [
      'ipaddr',
      'mongoid',
      'net/ssh',
    ]

    paths = {
      'net/ssh' => 'ssh',
    }

    modules = MODULES if [:all, 'all', '*'].include? modules

    modules.flatten.map(&:to_s).each do |_module|
      raise ArgumentException unless MODULES.include? _module

      require _module if needs_load.include? _module

      name = paths[_module] || _module
      require_relative "theusual/#{name}.rb"
    end
  end
end
