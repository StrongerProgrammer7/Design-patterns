require_relative File.dirname($0) + '/data_list_person_short.rb'
require_relative File.dirname($0) + './persons/person_short.rb'

require_relative '../../model_entity/Datatable/entities_list.rb'

class Persons_list < Entities_list

	def initialize(format_file)
		super(format_file)
	end

	def get_k_n_elements_list(k,n,data_list:nil,filter_initials:nil,filter_phone:nil,filter_mail:nil)
		self.list_entities = read_from_file(nil)
		list_persons_short = []
		index_elem = 0
		index_list = 0
		self.list_entities.each do |elem|
			if(index_elem == n && index_list < k) then
				index_list = index_list + 1
				index_elem = 0
			end
			if(index_list == k - 1 && index_elem <= n) then
				list_persons_short.push(Person_short.initialization(elem))
				if(index_elem == n)
					break
				end	
			end
			index_elem = index_elem + 1		
		end


		if(data_list == nil) then
			return Data_list_person_short.new(list_persons_short)
		else
			return data_list.list_entities = list_persons_short
		end
	end

	def sort_by_field(data_list)
		data_list.list_entities.sort! { |a,b| a.initials <=> b.initials}
	end
	
	def push_element(element)
		person = get_person(element)
		super(person)
	end

	def replace_element_by_id(id,element)
		person = get_person(element)
		super(person.id,person)
	end
	
	private 
	
		def get_person(element)
			raise 'This method should be oveeriden and retun entity'
		end
end