Brief explanation of design and assumptions:

This is a solution of Laser Maze problem. I worte it in Ruby and used Rspec for automated testing.
For inputs, there is an input.txt file exist in the io folder.

How to test solution

1. $ cd LaserMaze
2. Check output from the command line by running the command: $ ruby driver.rb <path-to-file>
5. To follow ruby guidelines i used two gems rubocop(https://github.com/bbatsov/rubocop) and ruby-lint(https://github.com/YorickPeterse/ruby-lint). We can check it by running command $ ./lint.sh
6. I also used simplecuv(https://github.com/colszowka/simplecov) to check test coverage which will run with rspec. Coverage/index.html is the generated report.

**** Versions ****
ruby 2.0.0p594
rubocop 0.28.0
ruby-lint v2.0.3
simplecuv 0.9.1
