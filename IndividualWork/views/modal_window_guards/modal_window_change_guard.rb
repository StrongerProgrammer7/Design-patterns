
require_relative  '../modal_Window.rb'


class Modal_change_guard < Modal_Window

	def initialize(app)
		super(app, "Change guard", width:350, height:250)
		
		
		@guard_field = {"name" =>nil,"surname" => nil, "lastname" => nil,
			"phone" => nil,"mail" => nil, "exp_year" => nil,"id" => nil}
		matrix = FXMatrix.new(self, 2, MATRIX_BY_COLUMNS|LAYOUT_FILL_X)

		create_inputs(matrix)
		@exp_year = create_textField(matrix,"exp_year",method(:check_years),method(:valid_years))
	
		@fields = {"name"=>@name,"surname"=>@surname,"lastname" =>@lastname,
			"phone" => @phone, "mail" => @mail,"exp_year" => @exp_year}
		create_close_button(matrix)
		@ok_btn = create_button_ok(matrix)
			
	end


	def get_personal_data(id)
		@guard_data = []
		@guard_data = @controller.get_element_by_id(id)
		if(@guard_data.class!=Guard) then
			@fields.each do |key,val|
				fill_inputs(val,key)
			end
		else
			fill_inputs_from_object()
		end
	end

private


	def create_button_ok(horizontal_frame)
		ok_button = FXButton.new(horizontal_frame, "Ok", nil,nil, :opts => BUTTON_NORMAL|LAYOUT_RIGHT)
		ok_button.connect(SEL_COMMAND) do |sender, selector, data|
			#TODO:Validate special field
			@guard_field["id"] = @guard_data["id"] if @guard_data.class != Owner
			@guard_field["exp_year"] = Integer(@guard_field["exp_year"])
			@controller.update_entity(@guard_field)
			removeTimeout(@timeout_id,@app)
			self.hide
		end
		ok_button.layoutHints |= LAYOUT_TOP|LAYOUT_RIGHT|LAYOUT_FILL_X
		ok_button
	end

	

	def create_textField(frame,name,method_check,method_validate)
		FXLabel.new(frame, name)
    	nameField = FXTextField.new(frame, 30)

    	nameField.connect(SEL_VERIFY) do |sender, sel, tentative|
    		if method_check.call(tentative)
    			false 
    		else		
    			true
    		end
    	end
    	nameField.connect(SEL_CHANGED) do 
    		validate_field(nameField,method_validate,name)
    	end

    	nameField
	end

	def fill_inputs(nameField,name)
		if @guard_data["#{name}"] != nil then
			nameField.setText(@guard_data["#{name}"].to_s) 
			@guard_field["#{name.downcase}"] = @guard_data["#{name}"]
		end
	end

	def fill_inputs_from_object()
		@name.text = @guard_data.name if @guard_data.name != nil
		@surname.text = @guard_data.surname if @guard_data.surname != nil
		@lastname.text = @guard_data.lastname if @guard_data.lastname != nil
		@phone.text = @guard_data.phone if @guard_data.phone != nil
		@mail.text = @guard_data.mail if @guard_data.mail != nil
		@exp_year.text = @guard_data.exp_year if @guard_data.exp_year != nil

		@guard_field["name"] = @guard_data.name if @guard_data.name != nil
		@guard_field["surname"] = @guard_data.surname if @guard_data.surname != nil
		@guard_field["lastname"] = @guard_data.lastname if @guard_data.lastname != nil
		@guard_field["phone"] = @guard_data.phone if @guard_data.phone != nil
		@guard_field["exp_year"] = @guard_data.exp_year if @guard_data.exp_year != nil
		@guard_field["mail"] = @guard_data.mail if @guard_data.mail != nil
		@guard_field["id"] = @guard_data.id
	end

	def validate_field(nameField,method_validate,name)
		if method_validate.call(nameField.text) then 
        	@guard_field[name.downcase] = nameField.text 
        else 
        	@guard_field[name.downcase] = nil 
        end
	end

	def require_field_to_fill()
		@guard_field["surname"]!=nil && @guard_field["name"] != nil  && @guard_field["phone"] != nil && @guard_field["exp_year"] != nil
	end

	

	def check_years(elem)
		elem.match?(/^[0-9]*$/)
	end

	
	def valid_years(elem)
		elem.match?(/^[0-9]{1,2}$/)
	end

	
end

