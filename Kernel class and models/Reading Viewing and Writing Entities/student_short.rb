load './person.rb'

class Student_short < Person
	attr_reader :initials, :contact

	def self.initialization(student)
		raise "require class's object Student" if(student.class!=Student)
		Student_short.new(id:student.id,information:student.getInfo())
	end

private
	attr_writer :initials, :contact

	def initialize(id:,information:)
		self.id = id
		data = information.split(",")
		self.initials = data[0]
		if data[1].include?("https:\/\/github") then 
			self.git = data[1]
			self.contact = data[2]
		else
			self.contact=data[1]
		end
	end
end
