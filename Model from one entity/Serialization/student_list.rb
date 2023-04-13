class Student_list
	def get_student_by_id(id)
		raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
	end

	def get_k_n_student_short_list(k,n,data_list:nil)
		raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
	end

	def push_student(student)
		raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
	end

	def replace_element_by_id(id,element)
		raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
	end

	def delete_element_by_id(id)
		raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
	end

	def get_student_short_count()
		raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
	end
end