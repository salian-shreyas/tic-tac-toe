class Player
	attr_reader :entries, :name

	def initialize(name)
		@entries = []
		@name = name
	end

	def get_entry
		puts "#{name} enter your position: "
		entries.push(gets.chomp.split(' ').map {|entry| entry.to_i})
	end

	private
	attr_writer :entries, :name
end
