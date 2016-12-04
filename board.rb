class	Board
	attr_accessor :grid

	def initialize
		@grid = Array.new(12, Array.new(4, '-'))
	end

	def display_grid
		puts "\n"
		@grid.each_slice(1) { |row| puts row.join(' | ') }
		puts "\n"
	end
end