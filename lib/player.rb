class Player
	attr_reader :entries, :name

	def initialize(name)
		self.name = name
		self.entries = {}
	end

	def get_entries
		puts "#{name} enter your position: "
		entries = gets.chomp.split(' ')
		self.entries[:row] = entries.first.to_i - 1
		self.entries[:col] = entries.last.to_i - 1
	end

	private
	attr_writer :entries, :name
end
