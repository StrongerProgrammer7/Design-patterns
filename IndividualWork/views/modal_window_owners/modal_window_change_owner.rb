
require_relative  '../modal_Window.rb'


class Modal_change_owner < Modal_Window

	def initialize(app)
		super(app, "Change owner", width:350, height:200)
		

		@owner_field = {"name" =>nil,"surname" => nil, "lastname" => nil,
			"phone" => nil,"mail" => nil, "id" => nil}
		matrix = FXMatrix.new(self, 2, MATRIX_BY_COLUMNS|LAYOUT_FILL_X)
	
		create_inputs(matrix)
		
		@fields = {"name"=>@name,"surname"=>@surname,"lastname" =>@lastname,
			"phone" => @phone, "mail" => @mail}
		create_close_button(matrix)
		@ok_btn = create_button_ok(matrix)
			
	end


	def get_personal_data(id)
		@owner_data = []
		@owner_data = @controller.get_element_by_id(id)
		if(@owner_data.class!=Owner) then
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
			@owner_field["id"] = @owner_data["id"] if @owner_data.class != Owner
			@controller.update_entity(@owner_field)
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
		if @owner_data["#{name}"] != nil then
			nameField.setText(@owner_data["#{name}"]) 
			@owner_field["#{name.downcase}"] = @owner_data["#{name}"]
		end
	end

	def fill_inputs_from_object()
		@name.text = @owner_data.name if @owner_data.name != nil
		@surname.text = @owner_data.surname if @owner_data.surname != nil
		@lastname.text = @owner_data.lastname if @owner_data.lastname != nil
		@phone.text = @owner_data.phone if @owner_data.phone != nil
		@mail.text = @owner_data.mail if @owner_data.mail != nil

		@owner_field["name"] = @owner_data.name if @owner_data.name != nil
		@owner_field["surname"] = @owner_data.surname if @owner_data.surname != nil
		@owner_field["lastname"] = @owner_data.lastname if @owner_data.lastname != nil
		@owner_field["phone"] = @owner_data.phone if @owner_data.phone != nil
		@owner_field["mail"] = @owner_data.mail if @owner_data.mail != nil
		@owner_field["id"] = @owner_data.id
	end

	def validate_field(nameField,method_validate,name)
		if method_validate.call(nameField.text) then 
        	@owner_field[name.downcase] = nameField.text 
        else 
        	@owner_field[name.downcase] = nil 
        end
	end

	def require_field_to_fill()
		@owner_field["surname"]!=nil && @owner_field["name"] != nil  && @owner_field["phone"] != nil
	end


end

