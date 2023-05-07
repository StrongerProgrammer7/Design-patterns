require_relative File.dirname($0) + '/person.rb'

class Student < Person
	def initialize(id:,surname:,name:,lastname:, phone:nil, telegram:nil,mail:nil,git:nil)
		super(surname:surname,name:name,lastname:lastname)
		set_information(phone:phone,mail:mail,telegram:telegram,git:git)
		self.id = id
	end

	def Student.initialization(information)
		raise "Not enough data or exists unnecessary data!(split [,])" if(information.count(",") < 2 || information.count(",") > 7)
		hash_data = Student.stringInformation_to_hash(information.delete(' ').split(","))
		Student.new(id:hash_data["id"],surname:hash_data["surname"],name:hash_data["name"],lastname:hash_data["lastname"],
			phone:hash_data["phone"],mail:hash_data["mail"],telegram:hash_data["telegram"],git:hash_data["git"])
	end

	def set_information(surname:nil,name:nil,lastname:nil, phone:nil,mail:nil,telegram:nil,git:nil)
		set_baseInfo(surname:surname,name:name,lastname:lastname)
		set_extraInfo(phone:phone,mail:mail,telegram:telegram,git:git)
	end

	def getInfo()
		"#{getSurname_Initials()}, #{getGit()}, #{getAnyContact()}"
	end

	private
		

		def self.stringInformation_to_hash(data)
			num = if (Person.check_word(data[3]) == nil) then 3 else 4 end
			hash_data = Hash.new
			hash_data["id"] = data[0]
			hash_data["surname"] = data[1]
			hash_data["name"]=data[2]
			hash_data["lastname"] = if num == 4 then data[3] else nil end
			data.drop(num).each do |i|
				next if(i==nil)
				if(i.include? "@") then
					(i[0]=='@') ? hash_data["telegram"] = i : hash_data["mail"] = i
				end
				hash_data["git"] = i if(i.include? "https:\/\/github") 
				hash_data["phone"] = i if(Person.check_phone(i)!=nil)
			end
			return hash_data
		end
	
		protected def getAnyContact()
			return "phone => #{self.phone} " if(self.phone!=nil)
			return "mail => #{self.mail} " if(self.mail !=nil)
			return "telegram => #{self.telegram} " if(self.telegram!=nil)
			return "have't contact" 
		end

end

