require_relative File.dirname($0) + '/person.rb'

class Student_short < Person
	attr_reader :initials, :contact

	def self.initialization(student)
		raise "require class's object Student" if(student.class!=Student)
		Student_short.new(id:student.id,information:student.getInfo())
	end

	def to_s()
		"#{self.initials}"
	end
	
private
	attr_writer :initials, :contact

	def initialize(id:,information:)
		self.id = id
		data = information.split(",")
		self.initials = data[0]
		self.git = if data[1].include?("https:\/\/github") then data[1] else "not have git"	end
		self.contact=data[2]
	end
end