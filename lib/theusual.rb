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
    # some modules need to be explicitly required
    needs_load = [
      'ipaddr',
      'mongoid',
      'net/ssh',
    ]

    # some of our filenames need to be remapped
    paths = {
      'net/ssh' => 'ssh',
    }

    raise ArgumentError if modules.empty?

    modules = MODULES if [:all, 'all', '*'].include? modules.first

    modules.flatten.map(&:to_s).each do |_module|
      raise ArgumentError unless MODULES.include? _module

      # load standard lib
      require _module if needs_load.include? _module

      # monkey patch
      name = paths[_module] || _module
      require_relative "theusual/#{name}.rb"
    end
  end
end
