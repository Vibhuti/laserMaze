class Laser
  NORTH = 'N'
  SOUTH = 'S'
  EAST = 'E'
  WEST = 'W'
  MIRROR_FORWARD = '/'
  MIRROR_BACK = '\\'

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

# If there is no mirror then player position direction will remain same and will keep moving until wall comes.
# But if any mirror come then we need to set new direction to the player position.
# if wall comes then it

  def moving_condition
    case player_position.direction
      when SOUTH
        player_position.y -= 1
      when NORTH
        player_position.y += 1
      when EAST
        player_position.x += 1
      when WEST
      else
    end
  end

  def move
    while(!wall? && !mirror?)
      moving_condition
      increase_distance
    end
    if wall?
      return
    end
    if mirror?
      direction_update
      move
    end
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
        puts "i came here"
        x == grid.cols - 1
      when WEST
        x == 0
      else
    end
  end

  def mirror?
    value = grid.get_value(player_position.x, player_position.y)
    value == '/' || value == '\\'
  end

  def increase_distance
    self.distance_traveled += 1
  end

  def direction_update
    str = grid.value(player_position.x, player_position.y)
    direction = player_position.direction
    player_position.direction = EAST if(str == MIRROR_BACK && direction == SOUTH)
    player_position.direction = SOUTH if(str == MIRROR_BACK && direction == EAST)
    player_position.direction = WEST if(str == MIRROR_BACK && direction == NORTH)
    player_position.direction = NORTH if(str == MIRROR_BACK && direction == WEST)
    player_position.direction = EAST if(str == MIRROR_FORWARD && direction == NORTH)
    player_position.direction = WEST if(str == MIRROR_FORWARD && direction == SOUTH)
    player_position.direction = SOUTH if(str == MIRROR_FORWARD && direction == WEST)
    player_position.direction = NORTH if(str == MIRROR_FORWARD && direction == EAST)
  end

end