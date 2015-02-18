  class Laser1

    NORTH = 'N'
    SOUTH = 'S'
    EAST = 'E'
    WEST = 'W'
    MIRROR_FORWARD = '/'
    MIRROR_BACK = '\\'

    attr_accessor :grid, :player_position, :distance_traveled, :player_starting_position, :starting_direction

    def initialize(lines = nil)
      set_inputs(lines)
    end

    def set_inputs(lines)
      return if lines.nil?
      set_grid_size(lines[0])
      set_player_starting_position(lines[1])
      if lines.length >= 2
        sub_line_array = lines[2..lines.length]
        sub_line_array.each do |i|
          update_grid(i)
        end
      end
    end

    def fire
      move_direction(player_starting_position.x, player_starting_position.y, self.starting_direction)
    end

    def is_mirror?(str)
      (str == MIRROR_FORWARD || str == MIRROR_BACK)
    end

    def to_s
      "\n #{player_position} and distance traveled is #{distance_traveled}\n"
    end

    def move_direction(x, y, direction)
      # return -1 if is_loop?(x, y, direction)
      x = player_position.x
      y = player_position.y
      # update_player_position(x, y)

      case direction
        when SOUTH
          move_south(x, y)
        when NORTH
          move_north(x, y)
        when EAST
          move_east(x, y)
        when WEST
          move_west(x, y)
        else
      end
    end
    private

    def move_south(x, y)
      direction = SOUTH
      while(moving_condition(x, y, direction)) do
        grid.update_cell(x, y, SOUTH)
        y -= 1
        increase_distance
        update_player_position(x, y)
      end
      mirror_condition(x, y, SOUTH)
    end

    def move_north(x, y)
      direction = NORTH
      while(moving_condition(x, y, direction)) do
        increase_distance
        y += 1
        update_player_position(x, y)
      end
      mirror_condition(x, y, NORTH)
    end

    def move_west(x, y)
      direction = WEST
      while(moving_condition(x, y, direction)) do
        x -= 1
        increase_distance
      end
      mirror_condition(x, y, WEST)
    end

    def move_east(x, y)
      direction = EAST
      while(moving_condition(x, y, direction)) do
        x += 1
        increase_distance
      end
      mirror_condition(x, y, EAST)
    end

    def moving_condition(x, y, direction)
      is_wall?(x, y, direction)&& !is_mirror?(grid.value(x, y))
    end

    def is_wall?(x, y, direction)
      case direction
        when SOUTH
          y > 0
        when NORTH
          y < (grid.rows)
        when EAST
          x < (grid.cols)
        when WEST
          x > 0
        else
      end
    end

    def increase_distance
      self.distance_traveled += 1
    end

    def mirror_condition(x, y, direction)
      if is_mirror?(grid.value(x,y))
        move_direction(x, y, direction_logic(grid.value(x,y), direction))
      end
    end

    def direction_logic(str, direction)
      return EAST if(str == MIRROR_BACK && direction == SOUTH)
      return SOUTH if(str == MIRROR_BACK && direction == EAST)
      return WEST if(str == MIRROR_BACK && direction == NORTH)
      return NORTH if(str == MIRROR_BACK && direction == WEST)
      return EAST if(str == MIRROR_FORWARD && direction == NORTH)
      return WEST if(str == MIRROR_FORWARD && direction == SOUTH)
      return SOUTH if(str == MIRROR_FORWARD && direction == WEST)
      return NORTH if(str == MIRROR_FORWARD && direction == EAST)
    end

    def set_grid_size(input_first_line)
       int_arr = split_input(input_first_line).map(&:to_i)
       self.grid = Grid1.new(int_arr)
    end

    def split_input(string_array)
      string_array.split(' ');
    end

    def set_player_starting_position(line)
      arr = split_input(line)
      x = arr[0].to_i
      y = arr[1].to_i
      update_grid(line)
      set_distance_travel
      self.player_starting_position = PlayerPosition.new(x, y, arr[2])
      self.player_position = player_starting_position
      self.starting_direction = self.player_position.direction
    end

    def update_grid(line)
      grid.double_array[split_input(line)[0].to_i][split_input(line)[1].to_i] = split_input(line)[2]
    end

    def set_distance_travel
      self.distance_traveled = 0
    end

    def exit_condition(x, y)
      x = player_position.x
      y = player_position.y
      direction = player_position.direction
      is_wall?(x, y, direction) || is_loop?(x, y, direction)
    end

    def is_loop?(x, y, direction)
      grid.double_array[x][y] == direction
    end

    def update_player_position(x, y)
      player_position.x = x
      player_position.y = y
    end

  end