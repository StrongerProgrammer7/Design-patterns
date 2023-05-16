
require 'fox16'
require 'clipboard'

include Fox

class Modal_create_owner < FXDialogBox

	attr_writer :controller
	def initialize(app)
		@app = app
		
		super(app, "Add owner", :width => 300, :height => 200)
		
		@owner_field = {"name" =>nil,"surname" => nil, "lastname" => "",
			"phone" => nil,"mail" => nil}
		matrix = FXMatrix.new(self, 2, MATRIX_BY_COLUMNS|LAYOUT_FILL_X)

		@list_text_fields = []
		@list_text_fields.push(create_textField(matrix,"Name",method(:check_letter),method(:validate_surname_name_lastname)))
		@list_text_fields.push(create_textField(matrix,"Surname",method(:check_letter),method(:validate_surname_name_lastname)))
		@list_text_fields.push(create_textField(matrix,"Lastname",method(:check_letter),method(:validate_surname_name_lastname)))
		@list_text_fields.push(create_textField(matrix,"Phone",method(:check_phone),method(:valid_phone)))
		@list_text_fields.push(create_textField(matrix,"Mail",method(:check_let_dig_specilSymbol),method(:valid_mail)))
	
		create_close_button(matrix)
		@ok_btn = create_button_ok(matrix)
			
	end

	def addTimeoutCheck(data:nil)
		if(self.shown?) then
			@timeout_id = @app.addTimeout(200, :repeat => true) do
				if require_field_to_fill() then
					 @ok_btn.enable  
				else
				 	 @ok_btn.disable 
				end
			end
		end
	end

private
	attr_reader :controller

	def create_close_button(horizontal_frame)
		close_button = FXButton.new(horizontal_frame, "Close", nil,nil, :opts => BUTTON_NORMAL|LAYOUT_RIGHT)
		close_button.connect(SEL_COMMAND) do |sender, selector, data|
			removeTimeout(@timeout_id,@app)
			self.hide
		end
		close_button.layoutHints |= LAYOUT_TOP|LAYOUT_RIGHT|LAYOUT_FILL_X
	end

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

	def removeTimeout(timerId,app)
		app.removeTimeout(timerId)
	end

	def check_letter(elem)
		elem.match?(/^[A-zА-яЁё\s]+$/) 
	end

	def check_phone(elem)
		elem.match?(/^\+?[0-9]*$/)
	end

	def check_let_dig_specilSymbol(elem)
		elem.match?(/\w+|[@]|[\.]|[:]|[\\]/)
	end


	def validate_surname_name_lastname(text)
		text.match?(/^[A-ZА-Я]([a-z]+|[a-яё]+)$/)
	end

	def valid_phone(text)
		text.match?(/^(\+7|8)[0-9]{9,15}$$/)
	end

	def valid_mail(text)
		text.match?(/^\w+[@][a-z]+[\.][a-z]{2,20}/)
	end


end

