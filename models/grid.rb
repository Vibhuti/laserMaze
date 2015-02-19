require 'pp'

class Grid
  attr_accessor :cols, :rows, :cells

  def initialize(cols, rows, position)
    self.rows = rows
    self.cols = cols
    self.cells  = Array.new(cols) {Array.new(rows, '-')}
    cells[position.x][position.y] = position.direction
  end

  def to_s
    "Grid columns= #{cols} and grid rows = #{rows}\n cells: \n#{cells}\n"
  end

  def get_value(x, y)
    cells[x][y]
  end

  def update_cell(arr)
    cells[arr[0].to_i][arr[1].to_i] = arr[2]
  end

  def update(lines)
    lines.each do |line|
      values = line.split(' ').to_a
      update_cell(values)
    end
  end
end