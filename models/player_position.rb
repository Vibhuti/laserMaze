class PlayerPosition

  attr_accessor :x, :y, :direction

  def initialize(x, y, direction)
    self.x = x
    self.y = y
    self.direction = direction
  end

  def to_s
    "Player position x coordinate = #{self.x} and y coordinate = #{self.y} and direction #{self.direction}"
  end
end