require './board.rb'
require './player.rb'

class Game
	attr_accessor :player1, :player2, :board

	@@turn = 0

	def initialize
		@board 		= Board.new
		@player1 	= Player.new
		@player2 	= Player.new(random_combination, true, "Minus")
		@guesser 	= @player1
		@master		= @player2
	end

	def random_combination
		@random =  (1..8).to_a.shuffle[1..4]
	end

	def start
		@player1.choose_name
		role
		@board.display_grid
		turn
	end
	
	def turn
		until @winner do
			@guess = @guesser.bot ? auto_guess : @guesser.try_guess
			grid_update
			@board.display_grid
			check_auto_guess
			@@turn += 1
			win?
		end
	end

	def role
		puts "You are guesser by default, do you want to play master instead? y/n"
		@answer = gets.chomp.to_s
		puts "\n"
		if @answer == "y"
			@guesser, @master = @master, @guesser 
			@master.choose_combination
		end
	end

	def grid_update
		@board.grid[@@turn] = @guess
	end

	def check_auto_guess
		@presence = @guess.select { |x| @master.combination.include? x }
		@sorted 	= @guess.select.with_index do |x, i|
									@guess[i] == @master.combination[i]
								end
		puts "Present: #{@presence.length}"
		puts "Sorted:  #{@sorted.length}"
		puts "\n"
	end

	def auto_guess
		(1..8).to_a.shuffle[1..4]
		# @auto_guess = []
		# @presence ? @auto_guess << @presence : @auto_guess = (1..8).to_a.shuffle[1..4]
		# @auto_guess << rand(1..8) until @auto_guess.length == 4
	end

	def win?
		if @guess == @master.combination
			@winner = @guesser
			puts "#{@guesser.name} penetrated the master mind!"
		elsif @@turn == 12
			@winner = @master
			puts "#{@master.name} mind still immaculate"
		end
	end
end

game = Game.new
game.start