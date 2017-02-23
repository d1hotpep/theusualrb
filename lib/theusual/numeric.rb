Numeric.module_eval do |m|
  m.const_set 'DELIMITER_REGEX', Regexp.new(/(\d)(?=(\d\d\d)+(?!\d))/)

  def with_delimiter delimiter = ','
    regex = Numeric.const_get 'DELIMITER_REGEX'
    int = to_i.to_s.gsub regex do |digits|
      "#{digits}#{delimiter}"
    end

    [
      int,
      to_s.split('.')[1]
    ].compact.join '.'
  end

end
