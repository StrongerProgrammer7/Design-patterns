
require 'fox16'

include Fox

class Modal_create_auto < FXDialogBox
	attr_writer :controller
	def initialize(app)
		@app = app
		
		super(app, "Add auto", :width => 300, :height => 200)
		
		@model_fileds = {"id_owner" =>nil,"model" => nil, "color" => nil,"surname_owner"=>nil,"mark"=>nil}
		matrix = FXMatrix.new(self, 2, MATRIX_BY_COLUMNS|LAYOUT_FILL_X)

		@number = create_textField(matrix,"id_owner",method(:check_digit),method(:validate_id)) 
		@model = create_textField(matrix,"Model",method(:check_letter),method(:validate_name))
		@color = create_textField(matrix,"Color",method(:check_letter),method(:validate_name))
	
		create_close_button(matrix)
		@ok_btn = create_button_ok(matrix)
			
	end

	def addTimeoutCheck(data:nil)
		if(self.shown?) then
			@timeout_id = @app.addTimeout(500, :repeat => true) do
				if @model_fileds["id_owner"]!=nil && @model_fileds["model"] != nil && @model_fileds["color"] != nil then
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
			@model_fileds["surname_owner"] = owner["surname"] if owner !=nil
			@model_fileds["mark"] = model["mark"] if model!=nil
			if owner!= nil && model != nil then
				answer = FXMessageBox.question(
							self,
							MBOX_YES_NO,
							"Just one question...",
							"Auto: #{owner["surname"]} #{model["model"]} #{model["mark"]} #{@model_fileds["color"]}"
							)
				if answer == MBOX_CLICKED_YES

					@controller.create_entity(@model_fileds)
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
	

	def validate_field(nameField,method_validate,name)
		if method_validate.call(nameField.text) then 
        	@model_fileds[name.downcase] = nameField.text 
        else 
        	@model_fileds[name.downcase] = nil 
        end
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

