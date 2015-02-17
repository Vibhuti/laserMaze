require 'minitest/autorun'
require '../models/laser'
require '../models/grid'
require '../models/player_position'


class TestLaserMaze < MiniTest::Unit::TestCase
  Lines = ["5 6", "1 4 S", "3 4 /", "3 0 /", "1 2 \\", "3 2 \\", "4 3 \\"]

  def setup
  end

  def test_grid_size
    laser_maze = Laser.new(Lines)
    assert_equal 5,  laser_maze.grid.cols
    assert_equal 6,  laser_maze.grid.rows
  end

  def test_grid_initialization_with_dash
    laser_maze = Laser.new(Lines)
    assert_equal '-',  laser_maze.grid.double_array[0][1]
  end

  def test_change_grid_value_with_starting_direction
    laser_maze = Laser.new(Lines)
    assert_equal 'S',  laser_maze.grid.double_array[1][4]
  end

  def test_distance_travel_zero_when_player_starts
    laser_maze = Laser.new(Lines)
    assert_equal 0,  laser_maze.distance_traveled
  end

  def test_other_inputs_and_grid_values
    laser_maze = Laser.new(Lines)
    assert_equal '/',  laser_maze.grid.double_array[3][4]
    assert_equal '\\',  laser_maze.grid.double_array[1][2]
  end

  def test_player_position_when_game_start
    laser_maze = Laser.new(Lines)
    assert_equal 1,  laser_maze.player_position.x
    assert_equal 4,  laser_maze.player_position.y
  end

  def test_exit_condition
    laser_maze = Laser.new(Lines)
     laser_maze.player_position.x = 0
    assert_equal true,  laser_maze.exit_condition( laser_maze.player_position)
  end

  def test_not_move_South
    laser_maze = Laser.new(Lines)
    assert_equal 0,  laser_maze.distance_traveled
  end

  def test_distance_traveled_should_be_zero
    laser_maze = Laser.new(Lines)
    assert_equal 0,  laser_maze.distance_traveled
  end

  def test_move_east
    laser_maze = Laser.new(Lines)
    assert_equal 2, laser_maze.move_direction(Laser::EAST)
  end

  def test_move_west
    laser_maze = Laser.new(Lines)
    assert_equal 1, laser_maze.move_direction(Laser::WEST)
  end

  def test_move_south_when_wall_hit
    lines = ["5 6", "1 1 S", "3 4 /", "3 0 /", "1 2 \\", "3 2 \\", "4 3 \\"]
    laser_maze = Laser.new(lines)
    assert_equal 1, laser_maze.move_direction(Laser::SOUTH)
  end

  def test_move_east_for_boundary_condition
    lines = ["5 6", "3 1 E", "3 4 /", "3 0 /", "1 2 \\", "3 2 \\", "4 3 \\"]
    laser_maze = Laser.new(lines)
    assert_equal 1, laser_maze.move_direction(Laser::EAST)
  end

  def test_move_south_for_boundary_condition
    lines = ["5 6", "2 0 S", "3 4 /", "3 0 /", "1 2 \\", "3 2 \\", "4 3 \\"]
    laser_maze = Laser.new(lines)
    assert_equal 0, laser_maze.move_direction(Laser::SOUTH)
  end

  def test_move_west_for_boundary_condition
    lines = ["5 6", "4 1 W", "3 4 /", "3 0 /", "1 2 \\", "3 2 \\", "4 3 \\"]
    laser_maze = Laser.new(lines)
    assert_equal 4, laser_maze.move_direction(Laser::WEST)
  end

  def test_move_north_for_boundary_condition
    lines = ["5 6", "2 1 N", "3 4 /", "3 0 /", "1 2 \\", "3 2 \\", "4 3 \\"]
    laser_maze = Laser.new(lines)
    assert_equal 4, laser_maze.move_direction(Laser::NORTH)
  end

end