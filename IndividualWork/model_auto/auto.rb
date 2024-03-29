class Auto
	attr_reader :id_owner,:model, :color,:surname_owner,:mark
	attr_accessor :id

	define_singleton_method :check_word do |word|
		/^(([A-z]+|[А-яё]+)\s*){2,99}$/.match(word)
	end
	
	define_singleton_method :check_number do |num|
		/^[0-9]+$/.match(num)
	end
	
	define_singleton_method :check_no_special_symbol do |word|
		/^[\-A-z0-9]+$/.match(word)
	end
	
	def initialize(id:,id_owner:,surname_owner:,model:,color:,mark:)
		set_baseInfo(id_owner:id_owner,surname_owner:surname_owner,model:model,color:color,mark:mark) 
		self.id = id
	end

	def self.initialization(information)
		raise "Not enough data or exists unnecessary data!(split [,])" if(information.count(",") > 6 || information.count(",") == 0)
		hash_data = Auto.string_to_hash(information.delete(' ').split(","))
		Auto.new(id:hash_data["id"],id_owner:Integer(hash_data["id_owner"]),surname_owner:hash_data["surname_owner"],model:hash_data["model"],color:hash_data["color"],mark:hash_data["mark"])
	end

	def to_s()
		"#{self.model} #{self.color}"
	end
	def set_baseInfo(id_owner:nil,surname_owner:nil,model:nil,color:nil,mark:nil)
		valid_baseField_onCorrect(id_owner:id_owner,surname_owner:surname_owner,model:model,color:color,mark:mark)
		self.id_owner = id_owner if(id_owner!=nil)
		self.surname_owner = surname_owner if(surname_owner != nil)
		self.model = model if (model!=nil)
		self.mark = mark if (mark!=nil)
		self.color = color if(color !=nil)
	end
	
	def get_info()
		"#{self.surname_owner}, #{self.model}, #{self.color}"
	end

		
	private
		attr_writer :id_owner,:model, :color,:surname_owner,:mark

		def self.string_to_hash(data)
			hash_data = Hash.new
			hash_data["id"] = data[0]
			hash_data["id_owner"] = data[1]
			hash_data["surname_owner"] = data[2]
			hash_data["model"] = data[3]
			hash_data["mark"] = data[4]	
			hash_data["color"] = data[5]
			hash_data
		end

		def valid_baseField_onCorrect(id_owner:,model:,color:,surname_owner:,mark:)
			if(color!=nil) then
				raise "Not valid color [A-Z][a-z]+ #{color}"  if(Auto.check_word(color) == nil || color.length > 50)
			end
			if(surname_owner!=nil) then
				raise "Not valid color [A-Z][a-z]+ #{surname_owner}"  if(Auto.check_word(surname_owner) == nil || surname_owner.length > 75)
			end
			if(id_owner!=nil) then
				raise "Not valid id_owner #{id_owner.to_s}"  if(Auto.check_number(id_owner.to_s) == nil)
			end
			if(model!=nil) then
				raise "Not valid model #{model}"  if(Auto.check_no_special_symbol(model) == nil)
			end
			if(mark!=nil) then
				raise "Not valid mark #{mark}"  if(Auto.check_no_special_symbol(mark) == nil)
			end
		end


end

=begin
define_singleton_method :check_date do |date|
		/^((\d{2}|\d{4})[\.|\-](0[1-9]|1[0-2])[\.|\-](0[1-9]|[1|2][0-9]|3[01])|(0[1-9]|[1|2][0-9]|3[01])[\.|\-](0[1-9]|1[0-2])[\.\-](\d{2}|\d{4}))$/.match(date)
	end
=end