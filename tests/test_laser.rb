require 'minitest/autorun'
require '../models/laser'
require '../models/grid'
require '../models/player_position'
require 'pp'

class TestLaserMaze < MiniTest::Unit::TestCase
  LINES = ["5 6", "1 4 S", "3 4 /", "3 0 /", "1 2 \\", "3 2 \\", "4 3 \\"]

  def setup

  end

  # Tests for initial setup before fire the event
  def test_grid_size_and_initialization_with_dash
    lines = ["5 6", "1 4 S"]
    laser_maze = Laser.new(lines)
    assert_equal 5,  laser_maze.grid.cols
    assert_equal 6,  laser_maze.grid.rows
  end

  def test_grid_initialization_with_dash
    lines = ["5 6", "1 4 S"]
    laser_maze = Laser.new(lines)
    assert_equal '-',  laser_maze.grid.cells[0][1]
  end

  def test_change_grid_value_with_starting_direction
    lines = ["5 6", "1 4 S"]
    laser_maze = Laser.new(lines)
    assert_equal 'S',  laser_maze.grid.cells[1][4]
  end

  def test_distance_travel_zero_when_player_starts
    lines = ["5 6", "1 4 S"]
    laser_maze = Laser.new(lines)
    assert_equal 0, laser_maze.distance_traveled
  end

  def test_other_inputs_and_grid_values
    lines = ["5 6", "1 4 S", "3 4 /", "3 0 /", "1 2 \\", "3 2 \\", "4 3 \\"]
    laser_maze = Laser.new(lines)
    assert_equal '/',  laser_maze.grid.cells[3][4]
    assert_equal '\\',  laser_maze.grid.cells[1][2]
  end

  def test_player_position_when_game_start
    lines = ["5 6", "1 4 S", "3 4 /", "3 0 /", "1 2 \\", "3 2 \\", "4 3 \\"]
    laser_maze = Laser.new(lines)
    assert_equal 1,  laser_maze.player_position.x
    assert_equal 4,  laser_maze.player_position.y
  end

  def test_starting_direction
     lines = ["5 6", "2 1 N", "3 4 /", "3 0 /", "1 2 \\", "3 2 \\", "4 3 \\"]
     laser_maze = Laser.new(lines)
     assert_equal 'N', laser_maze.player_position.direction
  end

  def test_before_fire_distance_traveled
     lines = ["5 6", "2 1 N", "3 4 /", "3 0 /", "1 2 \\", "3 2 \\", "4 3 \\"]
     laser_maze = Laser.new(lines)
     assert_equal 0, laser_maze.distance_traveled
  end

  # Tests for boundary condition and wall hit conditions

  def test_south_wall_hit_condition
    lines = ["5 6", "4 1 S"]
    laser_maze = Laser.new(lines)
    laser_maze.fire
    assert_equal 1, laser_maze.distance_traveled
  end

  def test_north_wall_hit_condition
    lines = ["5 6", "4 4 N"]
    laser_maze = Laser.new(lines)
    laser_maze.fire
    assert_equal 1, laser_maze.distance_traveled
  end

  def test_east_wall_hit_condition
    lines = ["5 6", "1 4 E"]
    laser_maze = Laser.new(lines)
    laser_maze.fire
    puts laser_maze.player_position
    assert_equal 3, laser_maze.distance_traveled
  end
  #
  # def test_move_south_wall_hit_condition
  #   lines = ["5 6", "1 1 S"]
  #   laser_maze = Laser1.new(lines)
  #   laser_maze.fire
  #   assert_equal 1, laser_maze.distance_traveled
  # end
  #
  # def test_move_east_for_boundary_condition
  #   lines = ["5 6", "4 3 E"]
  #   laser_maze = Laser1.new(lines)
  #   laser_maze.fire
  #   assert_equal 0, laser_maze.distance_traveled
  # end
  #
  # def test_move_west_boundary_condition
  #   lines = ["5 6", "0 4 W"]
  #   laser_maze = Laser1.new(lines)
  #   laser_maze.fire
  #   assert_equal 0, laser_maze.distance_traveled
  # end
  #
  # def test_move_south_for_boundary_condition
  #   lines = ["5 6", "2 0 S"]
  #   laser_maze = Laser1.new(lines)
  #   laser_maze.fire
  #   assert_equal 0, laser_maze.distance_traveled
  # end
  # #
  # # def test_update_grid_value_when_traverse_south
  # #   lines = ["5 6", "1 1 S"]
  # #   laser_maze = Laser.new(lines)
  # #   laser_maze.fire
  # #   assert_equal 1, laser_maze.distance_traveled
  # #   assert_equal Laser::SOUTH, laser_maze.grid.double_array[1][0]
  # # end
  #
  # # def test_update_grid_value_when_traverse_north
  # #    lines = ["5 6", "4 4 N"]
  # #    laser_maze = Laser.new(lines)
  # #    laser_maze.fire
  # #    assert_equal 1,  laser_maze.distance_traveled
  # #    assert_equal Laser::NORTH, laser_maze.grid.double_array[4][5]
  # # end
  #
  # def test_update_grid_value_when_traverse_east
  #    lines = ["5 6", "1 4 E"]
  #    laser_maze = Laser1.new(lines)
  #    laser_maze.fire
  #    assert_equal 3, laser_maze.distance_traveled
  #    # assert_equal Laser::EAST, laser_maze.grid.double_array[2][4]
  # end
  #
  # # def test_update_grid_value_when_traverse_west
  # #   lines = ["5 6", "1 3 W"]
  # #   laser_maze = Laser.new(lines)
  # #   laser_maze.fire
  # #   assert_equal 1, laser_maze.distance_traveled
  # #   assert_equal Laser::WEST, laser_maze.grid.double_array[0][3]
  # # end
  #
  #   # tests for changing direction when mirror comes
  #
  # def test_is_mirror_function
  #   laser_maze = Laser1.new(LINES)
  #   assert_equal true, laser_maze.is_mirror?(Laser1::MIRROR_FORWARD)
  #   assert_equal true, laser_maze.is_mirror?(Laser1::MIRROR_BACK)
  # end
  #
  # def test_back_slash_move_west_to_east
  #   lines = ["5 6", "1 4 S", "1 2 \\"]
  #   laser_maze = Laser1.new(lines)
  #   laser_maze.fire
  #   assert_equal 5, laser_maze.distance_traveled
  # end
  #
  # def test_forward_slash_move_south_to_west
  #   lines = ["5 6", "1 4 S", "1 2 /"]
  #   laser_maze = Laser1.new(lines)
  #   laser_maze.fire
  #   assert_equal 3, laser_maze.distance_traveled
  # end
  #
  # def test_forward_slash_move_east_to_north
  #   lines = ["5 6", "0 4 E", "3 4 /"]
  #   laser_maze = Laser1.new(lines)
  #   laser_maze.fire
  #   assert_equal 4, laser_maze.distance_traveled
  # end
  #
  # def test_back_slash_move_east_to_north
  #   lines = ["5 6", "0 4 E", "3 4 \\"]
  #   laser_maze = Laser1.new(lines)
  #   laser_maze.fire
  #   assert_equal 7, laser_maze.distance_traveled
  # end
  #
  # def test_forward_slash_move_west_to_north
  #   lines = ["5 6", "4 4 W", "3 4 /"]
  #   laser_maze = Laser1.new(lines)
  #   laser_maze.fire
  #   assert_equal 5, laser_maze.distance_traveled
  # end
  #
  # def test_back_slash_move_west_to_south
  #   lines = ["5 6", "4 4 W", "3 4 \\"]
  #   laser_maze = Laser1.new(lines)
  #   laser_maze.fire
  #   assert_equal 2, laser_maze.distance_traveled
  # end
  #
  # def test_forward_slash_move_north_to_west
  #   lines = ["5 6", "3 0 N", "3 2 \\"]
  #   laser_maze = Laser1.new(lines)
  #   laser_maze.fire
  #   assert_equal 5, laser_maze.distance_traveled
  # end
  #
  # def test_back_slash_move_north_to_east
  #   lines = ["5 6", "3 0 N", "3 2 /"]
  #   laser_maze = Laser1.new(lines)
  #   laser_maze.fire
  #   assert_equal 3, laser_maze.distance_traveled
  # end
  #
  # # def test_full
  # #   laser_maze = Laser.new(LINES)
  # #   laser_maze.fire
  # #   assert_equal 9, laser_maze.distance_traveled
  # # end
  #
  # def test_player_position_after_move
  #   lines = ["5 6", "3 0 N", "3 2 /"]
  #    laser_maze = Laser1.new(lines)
  #    laser_maze.fire
  #   pp laser_maze.grid
  #    assert_equal 4, laser_maze.player_position.x
  #   assert_equal 2, laser_maze.player_position.y
  # end
  #
  # def test_out
  #   lines = ["5 6", "3 0 N", "3 2 /"]
  #   laser_maze = Laser1.new(lines)
  #   laser_maze.fire
  #   puts laser_maze
  # end
end