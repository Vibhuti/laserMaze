require 'pp'

class Grid
  attr_accessor :cols, :rows, :double_array

  def initialize(arr)
    self.cols = arr[0]
    self.rows = arr[1]
    # TODO: Change name
    self.double_array  = Array.new(cols) {Array.new(rows, '-')}
  end

  def to_s
    "Grid columns= #{cols} and grid rows = #{rows}\n double array: \n#{double_array}\n"
  end

  def value(x, y)
    double_array[x][y]
  end

  def update_cell(x, y, direction)
    double_array[x][y] = direction
  end
end