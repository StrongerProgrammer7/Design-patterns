
require_relative  '../modal_Window.rb'

class Modal_create_owner < Modal_Window

	
	def initialize(app)
		super(app, "Add owner", width:300, height:200)
		@owner_field = {"name" =>nil,"surname" => nil, "lastname" => nil,
			"phone" => nil,"mail" => nil, "id" => nil}

		matrix = FXMatrix.new(self, 2, MATRIX_BY_COLUMNS|LAYOUT_FILL_X)

		create_inputs(matrix)
		@list_text_fields = []
		@list_text_fields.push(@name)
		@list_text_fields.push(@surname)
		@list_text_fields.push(@lastname)
		@list_text_fields.push(@phone)
		@list_text_fields.push(@mail)
	
		create_close_button(matrix)
		@ok_btn = create_button_ok(matrix)
			
	end

	

private

	def create_button_ok(horizontal_frame)
		ok_button = FXButton.new(horizontal_frame, "Ok", nil,nil, :opts => BUTTON_NORMAL|LAYOUT_RIGHT)
		ok_button.disable
		ok_button.connect(SEL_COMMAND) do |sender, selector, data|
			#TODO:Validate special field
			removeTimeout(@timeout_id,@app)
			@controller.create_entity(@owner_field)
			clear_fields()
			self.hide
		end
		ok_button.layoutHints |= LAYOUT_TOP|LAYOUT_RIGHT|LAYOUT_FILL_X
		ok_button
	end

	def create_textField(frame,name,method_check,method_validate)
		FXLabel.new(frame, name)
    	nameField = FXTextField.new(frame, 20)

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

	def validate_field(nameField,method_validate,name)
		if method_validate.call(nameField.text) then 
        	@owner_field[name.downcase] = nameField.text 
        else 
        	@owner_field[name.downcase] = nil 
        end
	end

	def clear_fields()
		@list_text_fields.each do |elem|
			elem.setText('')
		end
		@owner_field.each do |key,val|
			@owner_field[key] = nil
		end
	end

	def require_field_to_fill()
		@owner_field["surname"]!=nil && @owner_field["name"] != nil  && @owner_field["phone"] != nil
	end

	
end

