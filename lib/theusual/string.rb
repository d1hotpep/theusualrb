
class String

  def is_f?
    self == self.to_f.to_s rescue false
  end


  def is_i?
    self == self.to_i.to_s and !self.include? '.' rescue false
  end


  def numeric?
    is_f?
  end


  def to_bool
    if self.downcase == 'false'
      false
    elsif self.downcase == 'true'
      true
    else
      raise ArgumentError.new "expected 'true' or 'false', got: #{self}"
    end
  end

end
