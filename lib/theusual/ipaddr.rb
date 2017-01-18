class IPAddr
  class << self
    # eg. 8.8.8 => 8.8.8.0/24
    def new(addr = '::', family = Socket::AF_UNSPEC)
      # already an IPAddr, so simply return a clone
      return addr.clone if addr.is_a? IPAddr

      addr ||= '::'
      if addr == '::'
        family = Socket::AF_INET6
      elsif !addr.inspect.include? '/'
        addr = addr.to_s
        count = addr.split('.').count
        if (1..3).include? count
          # given a shortened addr...kindly reformat
          addr = case count
          when 3
            addr + '.0/24'
          when 2
            addr + '.0.0/16'
          when 1
            addr + '.0.0.0/8'
          end
        end
      end

      super addr, family
    end
  end


  # eg. 8.8.8.8/24 => 8.8.8
  def short(size = nil)
    if ipv4?
      unless size
        mask = inspect.split('/')[1].chomp('>')
        size = 8 * mask.split('.').select {|x| x == '255'}.count
      end

      case size
      when 32
        to_s
      when 24
        to_s.split('.').first(3).join('.')
      when 16
        to_s.split('.').first(2).join('.')
      when 8
        to_s.split('.').first
      else
        to_s
      end
    end
  end
end
