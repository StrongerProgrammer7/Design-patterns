require_relative File.dirname($0) + '/data_list_auto.rb'
require_relative '../../model_entity/Datatable/entities_list.rb'

class Auto_list < Entities_list

	def initialize(format_file)
		super(format_file)
	end

	def get_k_n_elements_list(k,n,data_list:nil)
		self.list_entities = read_from_file(nil)
		list = []
		index_elem = 0
		index_list = 0
		self.list_entities.each do |elem|
			if(index_elem == n && index_list < k) then
				index_list = index_list + 1
				index_elem = 0
			end
			if(index_list == k - 1 && index_elem <= n) then
				list.push(elem)
				if(index_elem == n)
					break
				end	
			end
			index_elem = index_elem + 1		
		end


		if(data_list == nil) then
			return Data_list_auto.new(list)
		else
			return data_list.list_entities = list
		end
	end

	def sort_by_field(data_list)
		data_list.list_entities.sort! { |a,b| a.model <=> b.model}
	end

	def push_element(element)
		auto = create_auto(element:element)
		super(auto)
	end

	def replace_element_by_id(id,element)
		auto = create_auto(element:element,id:id)
		super(id,auto)
	end
	
	private
	def create_auto(element:,id:nil)
		Auto.new(id:id,id_owner:element["id_owner"],
      				model:element["model"],
      				color:element["color"])
	end


end