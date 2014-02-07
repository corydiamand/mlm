class String
  def to_fmquery
    "-" + URI.encode(self)
  end    
end