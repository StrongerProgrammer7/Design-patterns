require_relative File.dirname($0) + '/data_list_labs.rb'
require_relative '../../model_entity/Datatable/entities_list.rb'

class Labs_list < Entities_list

	def initialize(format_file)
		super(format_file)
	end

	def get_k_n_elements_list(k,n,data_list:nil)
		self.list_entities = read_from_file(@@addressFile)
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
			return Data_list_labs.new(list)
		else
			return data_list.list_entities = list
		end
	end

	def sort_by_name(data_list)
		data_list.list_entities.sort! { |a,b| a.name <=> b.name}
	end

end