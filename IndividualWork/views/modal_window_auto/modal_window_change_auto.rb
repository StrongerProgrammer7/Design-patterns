
require 'fox16'

include Fox

class Modal_change_auto < FXDialogBox
	attr_writer :controller
	def initialize(app)
		@app = app
		
		super(app, "Change auto", :width => 300, :height => 150)
		
		@model_filed = {"id"=>nil,"id_owner" =>nil,"model" => nil, "color" => nil,"surname_owner"=>nil,"mark"=>nil}
		matrix = FXMatrix.new(self, 2, MATRIX_BY_COLUMNS|LAYOUT_FILL_X)
	
		@number = create_textField(matrix,"id_owner",method(:check_digit),method(:validate_id)) 
		@model = create_textField(matrix,"Model",method(:check_letter),method(:validate_name))
		@color = create_textField(matrix,"Color",method(:check_letter),method(:validate_name))

		@fields = {"number"=>@number,"model"=>@model,"color" =>@color}
		create_close_button(matrix)
		@ok_btn = create_button_ok(matrix)
			
	end

	def addTimeoutCheck(data:nil)
		if(self.shown?) then
			@timeout_id = @app.addTimeout(500, :repeat => true) do
				if @model_filed["id_owner"]!=nil && @model_filed["model"] != nil && @model_filed["color"] != nil then
					 @ok_btn.enable  
				else
				 	 @ok_btn.disable 
				end
			end
		end

	end

	def get_personal_data(id)
		@model_data = []
		@model_data = @controller.get_element_by_id(id)

		if(@model_data.class != Auto) then
			@fields.each do |key,val|
				fill_inputs(val,key)
			end
			@number.setText(@model_data["owner_id"].to_s)
			@model_filed["id_owner"] = @model_data["owner_id"]
			@model_filed["id"] = @model_data["id"]
		else
			fill_inputs_from_object()
		end
	end

private
	attr_reader :controller
	def create_close_button(horizontal_frame)
		close_button = FXButton.new(horizontal_frame, "Close", nil,nil, :opts => BUTTON_NORMAL|LAYOUT_RIGHT)
		close_button.connect(SEL_COMMAND) do |sender, selector, data|
			@app.removeTimeout(@timeout_id)
			clear_inputs()
			self.hide
		end
		close_button.layoutHints |= LAYOUT_TOP|LAYOUT_RIGHT|LAYOUT_FILL_X
	end

	def create_button_ok(horizontal_frame)
		ok_button = FXButton.new(horizontal_frame, "Ok", nil,nil, :opts => BUTTON_NORMAL|LAYOUT_RIGHT)
		ok_button.disable
		ok_button.connect(SEL_COMMAND) do |sender, selector, data|
			owner = @controller.get_owner(@number.text.to_i)
			model = @controller.get_model(@model.text)
			@model_filed["surname_owner"] = owner["surname"] if owner !=nil
			@model_filed["mark"] = model["mark"] if model!=nil
			print @model_filed,"\n"
			if owner!= nil && model != nil then
				answer = FXMessageBox.question(
							self,
							MBOX_YES_NO,
							"Just one question...",
							"Auto: #{owner["surname"]} #{model["model"]} #{model["mark"]} #{@model_filed["color"]}"
							)
				if answer == MBOX_CLICKED_YES

					@controller.update_entity(@model_filed)
					@app.removeTimeout(@timeout_id)
					clear_inputs()
					self.hide
				end
			else				
				FXMessageBox.warning(self,MBOX_OK,"Warning",
					"Owner/model don't exists, show directory!")
			end


			
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

	def fill_inputs(nameField,name)
		nameField.setText(@model_data["#{name}"].to_s) if @model_data["#{name}"] != nil
		@model_filed["#{name.downcase}"] = @model_data["#{name}"] if @model_data["#{name}"] != nil
	end

	def fill_inputs_from_object()
		@number.text = @model_data.id_owner if @model_data.id_owner != nil
		@model.text = @model_data.model if @model_data.model != nil
		@color.text = @model_data.color if @model_data.color != nil

		@model_filed["id_owner"] = @model_data.id_owner if @model_data.id_owner != nil
		@model_filed["model"] = @model_data.model if @model_data.model != nil
		@model_filed["color"] = @model_data.color if @model_data.color != nil
		@model_filed["mark"] = @model_data.mark if @model_data.mark != nil
		@model_filed["surname_owner"] = @model_data.surname_owner if @model_data.surname_owner != nil
		@model_filed["id"] = @model_data.id
	end

	def validate_field(nameField,method_validate,name)
		if method_validate.call(nameField.text) then 
        	@model_filed[name.downcase] = nameField.text 
        else 
        	@model_filed[name.downcase] = nil 
        end
	end

	def message(text)
		FXMessageBox.warning(self,
			MBOX_OK,
			"Warning",
			text)
	end

	def clear_inputs()
		@name.setText('')
		@tasks.setText('')
		@topics.setText('')
		@date.setText('')
	end



	def clear_inputs()
		@number.setText('')
		@color.setText('')
		@model.setText('')
	end


	def check_letter(elem)
		elem.match?(/^[A-zА-яЁё\s\-0-9\#]+$/) 
	end

	def check_digit(elem)
		elem.match?(/^[0-9]+$/)
	end

	def validate_name(text)
		text.match?(/^[A-z \-0-9\#]{1,99}$/)
	end

	def validate_id(text)
		text.match?(/^[0-9]{1,999}$/)
	end



end

