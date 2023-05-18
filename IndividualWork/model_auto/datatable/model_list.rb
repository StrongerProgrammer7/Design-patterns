require_relative File.dirname($0) + '/data_list_model.rb'
require_relative '../../model_entity/Datatable/entities_list.rb'

class Model_list < Entities_list

	def initialize(format_file)
		super(format_file)
	end

	def get_k_n_elements_list(k,n,data_list:nil,filter_initials:nil,filter_phone:nil,filter_mail:nil)
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
			return Data_list_model.new(list)
		else
			return data_list.list_entities = list
		end
	end
#-----------Refactoring - include yeald
	def get_element_by_id(id)
		self.list_entities.each do |elem|
			if(elem.model == id) then
				return elem
			end
		end
		return nil
	end


	def sort_by_field(data_list)
		data_list.list_entities.sort! { |a,b| a.mark <=> b.mark}
	end

	def push_element(element)
		model = create_model(element:element,id:element["model"])
		self.list_entities.push(model)
	end

	def replace_element_by_id(id,element)
		model = create_model(element:element,id:id)
		self.list_entities.map! { |elem|  elem.model == id ? model : elem }
	end

	def delete_element_by_id(id)
		self.list_entities.delete_if { |elem| elem.model == id }
	end
	
	private
	def create_model(element:,id:nil)
		Model.new(model:id,mark:element["mark"])
	end


end