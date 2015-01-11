class Media
  
  attr_reader :location, :file, :size
  
  def initialize(location, file, size)
    @location = location
    @file = file
    @size = size
  end
end