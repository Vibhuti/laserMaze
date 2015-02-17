require 'pp'

class Grid
  attr_accessor :cols, :rows, :double_array

  def initialize(arr)
    self.cols = arr[0]
    self.rows = arr[1]
    self.double_array  = Array.new(cols) {Array.new(rows, '-')}
  end

  def to_s
    "Grid columns= #{cols} and grid rows = #{rows}\n double array: #{double_array}"
  end

end