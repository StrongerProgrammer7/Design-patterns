class Model
	attr_reader :mark
	attr_accessor :model

	define_singleton_method :check_no_special_symbol do |word|
		/^[\-A-z0-9]+$/.match(word)
	end
	
	def initialize(model:,mark:)
		set_baseInfo(model:model,mark:mark) 
	end

	def self.initialization(information)
		raise "Not enough data or exists unnecessary data!(split [,]) #{information}" if(information.count(",") > 2 || information.count(",") == 0)
		hash_data = Model.string_to_hash(information.delete(' ').split(","))
		Model.new(mark:hash_data["mark"],model:hash_data["model"])
	end

	def to_s()
		"#{self.mark} #{self.model}"
	end
	def set_baseInfo(model:nil,mark:nil)
		valid_baseField_onCorrect(model:model,mark:mark)
		self.mark = mark if(mark!=nil)
		self.model = model if (model!=nil)
	end
	
		
	private
		attr_writer :mark

		def self.string_to_hash(data)
			hash_data = Hash.new
			hash_data["model"] = data[0]	
			hash_data["mark"] = data[1]
			hash_data
		end

		def valid_baseField_onCorrect(mark:,model:)
			if(mark!=nil) then
				raise "Not valid mark #{mark}"  if(Model.check_no_special_symbol(mark) == nil)
			end
			if(model!=nil) then
				raise "Not valid model #{model}"  if(Model.check_no_special_symbol(model) == nil)
			end
		end


end

=begin
define_singleton_method :check_date do |date|
		/^((\d{2}|\d{4})[\.|\-](0[1-9]|1[0-2])[\.|\-](0[1-9]|[1|2][0-9]|3[01])|(0[1-9]|[1|2][0-9]|3[01])[\.|\-](0[1-9]|1[0-2])[\.\-](\d{2}|\d{4}))$/.match(date)
	end
=end