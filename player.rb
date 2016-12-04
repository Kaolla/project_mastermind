class Player
	attr_accessor :name, :combination, :bot

	def initialize(combination = nil, bot = false, name = nil)
		@name = name
		@combination = combination
		@bot = bot
	end

	def choose_name
		puts "What's your name?"
		@name = gets.chomp.to_s
		puts "Welcome #{@name}, I'm Minus. Let's play..."
		puts "\n"
	end

	def choose_combination
		puts "Choose your combination, four numbers between 1 and 8."
		@combination = gets.chomp.to_s.split('').map { |x| x.to_i }
		puts "Your combination is #{@combination}."
		puts "\n"
	end

end