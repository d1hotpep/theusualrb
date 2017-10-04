class Array
  #####  Numerical Operations  #####
  def sum
    numerics?
    inject 0, &:+
  end
  alias_method :total, :sum


  def avg
    numerics?
    return Float::NAN if empty?

    map(&:to_f).sum / count
  end
  alias_method :average, :avg
  alias_method :mean, :avg


  def std
    numerics?
    return Float::NAN if empty?

    mean = avg

    Math.sqrt(
        map { |sample| (mean - sample.to_f) ** 2 }.reduce(:+) / count.to_f
    )
  end
  alias_method :standard_deviation, :std


  #####  String Operations  #####
  def grepv regex
    reject { |elem| elem =~ regex }
  end


  def gsub(regex, replacement)
    clone.gsub! regex, replacement
  end

  def gsub!(regex, replacement)
    map! { |string| string.gsub(regex, replacement) }
  end


  #####  Misc Operations  #####
  def compact(modifier = nil)
    falsy = modifier == :falsy
    blanks = falsy || modifier == :blanks

    reject do |v|
      isblank = blanks && v.respond_to?(:empty?) && v.empty?
      isfalsy = falsy && (v == 0)

      !v || isblank || isfalsy
    end
  end

  def compact!(modifier = nil)
    res = compact(modifier)
    clear

    # TODO: is there a better way than shift/reverse?
    res.each {|x| unshift x}
    reverse!
  end


  private

  def numerics?
    # make sure values are all Numeric or numbers within strings
    map do |x|
      Float(x)
    end
  end

end
