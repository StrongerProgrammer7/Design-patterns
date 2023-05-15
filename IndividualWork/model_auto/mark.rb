class Mark
	attr_accessor :mark
	
	define_singleton_method :check_no_special_symbol do |word|
		/^[\-A-z0-9]+$/.match(word)
	end
	
	def initialize(mark:)
		set_baseInfo(mark:mark) 
	end

	def self.initialization(information)
		raise "exists unnecessary data!(split [,])" if(information.count(",") > 0)
		hash_data = Mark.string_to_hash(information.delete(' ').split(","))
		Mark.new(mark:hash_data["mark"])
	end

	def to_s()
		"#{self.mark}"
	end
	def set_baseInfo(mark:nil)
		valid_baseField_onCorrect(mark:mark)
		self.mark = mark if(mark!=nil)
	end
			
	private

		def self.string_to_hash(data)
			hash_data = Hash.new
			hash_data["mark"] = data[0]
			hash_data
		end

		def valid_baseField_onCorrect(mark:)
			if(mark!=nil) then
				raise "Not valid model #{mark}"  if(Mark.check_no_special_symbol(mark) == nil)
			end
		end


end
