
require 'fox16'
require 'clipboard'

include Fox

class Modal_change_owner < FXDialogBox

	attr_writer :controller
	def initialize(app)
		@app = app

		super(app, "Change owner", :width => 400, :height => 250)
		
		@owner_field = {"name" =>nil,"surname" => nil, "lastname" => nil,
			"phone" => nil,"mail" => nil, "id" => nil}
		matrix = FXMatrix.new(self, 2, MATRIX_BY_COLUMNS|LAYOUT_FILL_X)

		@name = create_textField(matrix,"Name",method(:check_letter),method(:validate_surname_name_lastname))
		@surname = create_textField(matrix,"Surname",method(:check_letter),method(:validate_surname_name_lastname))
		@lastname = create_textField(matrix,"Lastname",method(:check_letter),method(:validate_surname_name_lastname))
		@phone = create_textField(matrix,"Phone",method(:check_phone),method(:valid_phone))
		@mail = create_textField(matrix,"Mail",method(:check_let_dig_specilSymbol),method(:valid_mail))
	
		@fields = {"name"=>@name,"surname"=>@surname,"lastname" =>@lastname,
			"phone" => @phone, "mail" => @mail}
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

