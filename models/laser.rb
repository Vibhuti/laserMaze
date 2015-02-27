class Laser
  NORTH = 'N'
  SOUTH = 'S'
  EAST = 'E'
  WEST = 'W'
  MIRROR_FORWARD = '/'
  MIRROR_BACK = '\\'

  HASH = {'N' => 'NORTH', 'S' => 'SOUTH', 'E' => 'EAST', 'W' => 'WEST', '/' => 'MIRROR_FORWARD', '\\' => 'MIRROR_BACK'}

  DECISION_HASH = { 'MIRROR_BACK_SOUTH' => EAST,
                    'MIRROR_BACK_EAST' => SOUTH,
                    'MIRROR_BACK_NORTH' => WEST,
                    'MIRROR_BACK_WEST' => NORTH,
                    'MIRROR_FORWARD_NORTH' => EAST,
                    'MIRROR_FORWARD_SOUTH' => WEST,
                    'MIRROR_FORWARD_WEST' => SOUTH,
                    'MIRROR_FORWARD_EAST' => NORTH
                  }

  attr_accessor :grid, :player_position, :distance_traveled, :new_direction

  def initialize(lines)
    set_initial_inputs(lines)
  end

  def fire
    move
  end

private
  def set_initial_inputs(lines)
    position_arr = lines[1].split(' ').to_a
    x = position_arr[0].to_i
    y = position_arr[1].to_i
    direction = position_arr[2]
    self.player_position = PlayerPosition.new(x, y, direction)
    update_grid(lines)
  end

  def update_grid(lines)
    grid_int_arr = lines[0].split(' ').to_a.map(&:to_i)
    self.grid = Grid.new(grid_int_arr[0], grid_int_arr[1], player_position)
    self.distance_traveled = 0
    if lines.length > 2
      sub_line_array = lines[2..lines.length]
      grid.update(sub_line_array)
    end
  end

  def moving_condition
    case player_position.direction
      when SOUTH
        player_position.y -= 1
      when NORTH
        player_position.y += 1
      when EAST
        player_position.x += 1
      when WEST
        player_position.x -= 1
      else
    end
  end

  def move
    while !wall? && !mirror?
      moving_condition
      increase_distance
    end

    if mirror?
      direction_update
      grid.update_cell(player_position.get_values)
      move
    end

    return if wall?
  end

  def wall?
    x = player_position.x
    y = player_position.y
    direction = player_position.direction
    case direction
      when SOUTH
        y == 0
      when NORTH
        y == grid.rows - 1
      when EAST
        x == grid.cols - 1
      when WEST
        x == 0
      else
    end
  end

  def mirror?
    value = grid.get_value(player_position.x, player_position.y)
    value == '/' || value == "\\"
  end

  def increase_distance
    self.distance_traveled += 1
  end

  def direction_update
    str = grid.get_value(player_position.x, player_position.y)
    direction = player_position.direction
    combind_str = "#{HASH[str]}_#{HASH[direction]}"
    new_direction combind_str
  end


  def new_direction combind_str
    player_position.direction = DECISION_HASH[combind_str]
  end

end