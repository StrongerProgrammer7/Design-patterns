class Student
	#attr_accessor :surname, :name, :lastname, :phone, :telegram, :mail, :git
	#attr_reader :ID
	
	def initialize(surname,name,lastname, phone:nil, telegram:nil,mail:nil,git:nil)
		@name = name
		@surname = surname
		@lastname = lastname
		@phone = phone
		@telegram = telegram
		@mail = mail
		@git = git
		self.ID = @@countStudents
		@@countStudents = @@countStudents + 1
	end

	def get_surname
		@surname
	end
	def get_name
		@name
	end
	def get_lastname
		@lastname
	end
	def get_phone
		@phone
	end
	def get_telegram
		@telegram
	end
	def get_mail
		@mail
	end
	def get_git
		@git
	end
	def get_ID
		@ID
	end

	def set_surname=(surname)
		@surname=surname
	end
	def set_name=(name)
		@name=name
	end
	def set_lastname=(lastname)
		@lastname=lastname
	end
	def set_phone=(phone)
		@phone=phone
	end
	def set_telegram=(telegram)
		@telegram=telegram
	end
	def set_mail=(mail)
		@mail=mail
	end
	def set_git=(git)
		@git=git
	end

	def print_current_info()
		print "ID\tname\tlastname\tphone\n"
		print "#{get_ID}\t#{get_name}\t#{get_lastname}\t#{get_phone}\n"
	end

	private
	@@countStudents = 0
	attr_writer :ID
end
