
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


end
