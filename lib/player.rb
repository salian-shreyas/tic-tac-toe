class Player
	attr_reader :entries

	def initialize
		@entries = []
	end

	def get_entry
		puts "Enter your position: "
		entries.push(gets.chomp.split(' ').map {|entry| entry.to_i})
	end

	private
	attr_writer :entries
end
