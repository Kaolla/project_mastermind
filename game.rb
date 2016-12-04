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
		(1..8).to_a.shuffle[1..4]
	end

	def random_num
		rand(1..8)
	end

	def start
		@player1.choose_name
		set_role
		@board.display_grid
		turn until @winner
	end

	def set_role
		puts "You are guesser by default, do you want to play master instead? y/n"
		answer = gets.chomp.to_s
		puts "\n"
		if answer == "y"
			@guesser, @master = @master, @guesser 
			@master.choose_combination
		end
	end
	
	def turn
		@guess = guess
		grid_update
		@board.display_grid
		check_guess
		@@turn += 1
		win?
	end

	def guess
		if @guesser.bot
			auto_guess = @presence ? @presence : random_combination
			while auto_guess.length < 4
				auto_guess << random_num unless auto_guess.include? random_num
				auto_guess.uniq!
			end
			auto_guess.shuffle
		else
			puts "============================="
			puts "Try to guess the combination, four numbers between 1 and 8!"
			gets.chomp.to_s.split('').map { |x| x.to_i }
		end
	end

	def check_guess
		@presence = @guess.select { |x| @master.combination.include? x }
		@sorted 	= @guess.select.with_index { |x, i| x == @master.combination[i] }

		puts "Present: #{@presence.length}"
		puts "Sorted:  #{@sorted.length}"
		puts "\n"
	end

	def grid_update
		@board.grid[@@turn] = @guess
	end

	private

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