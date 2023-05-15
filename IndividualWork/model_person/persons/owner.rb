require_relative '../../model_entity/parent_entities/person.rb'

class Owner < Person
	def initialize(id:,surname:,name:,lastname:, phone:,mail:nil)
		super(surname:surname,name:name,lastname:lastname,phone:phone,mail:mail)
		self.id = id
	end

	def Owner.initialization(information)
		raise "Not enough data or exists unnecessary data!(split [,])" if(information.count(",") < 4 || information.count(",") > 7)
		hash_data = Owner.string_to_hash(information.delete(' ').split(","))
		Owner.new(id:hash_data["id"],surname:hash_data["surname"],name:hash_data["name"],lastname:hash_data["lastname"],
			phone:hash_data["phone"],mail:hash_data["mail"])
	end
	
	private
	
		def self.string_to_hash(data)
			num = if (Person.check_word(data[3]) == nil) then 3 else 4 end
			hash_data = Hash.new
			hash_data["id"] = data[0]
			hash_data["surname"] = data[1]
			hash_data["name"]=data[2]
			hash_data["lastname"] = if num == 4 then data[3] else nil end
			data.drop(num).each do |i|
				next if(i==nil)
				hash_data["mail"] = i if(Person.check_mail(i)!=nil) 
				hash_data["phone"] = i if(Person.check_phone(i)!=nil)
			end
			return hash_data
		end
end

