#Методы которые находям мин, № первый полож элемент
#Task 1 ------------------------------------------
def minElement(array)
	if(array.length==0) then
		return 0
	end
	if(array.length==1) then
		return array[0]
	end
	min = array[1]
	for i in array
		if(min>i) then
			min = i
		end
	end
	return min
end
#puts minElement([1,2,0,4,1])
#-------------------------------------------------
def numberFirstPossitiveElement(array)
	if(array.length==0) then
		return -1
	end
	if(array.length==1 and array[0] > 0) then
		return 0
	elsif array.length==1 then
		return -1
	end
	for i in array
		if(i>0) then
			return array.index(i)
		end
	end
	return -1			
end

#puts numberFirstPossitiveElement([-1,2,-3,5])
#Task 2--------------------------------------------

def operationOverArray(nameMethod,addressFile)
	#binding.irb
	#current_path = File.dirname(__FILE__)
	file_path = addressFile#current_path + "/" + addressFile
	if File.exist?(file_path) then
		array = (File.open(file_path,'r'){ |file| file.read }).split(' ').map{|item| item.to_i}
		if(nameMethod=="numberFirstPossitiveElement") then
			number = numberFirstPossitiveElement(array)
			print "№" + number.to_s + " = " + array[number].to_s + "\n"
			return number
		elsif(nameMethod=="minElement") then
			return minElement(array)
		else
			print "Method don't exists"
			return nil
		end

	else
		print "Error! File don't exists!"
		return nil
	end
	return ""
end

#puts "addressFile?"
#address = STDIN.gets.chomp
#fileArray = File.open(address,'r'){ |file| file.read }
current_path = File.dirname(__FILE__)
file_path = current_path + "/" + ARGV[1]
if(ARGV[0]=="minElement") then
	if File.exist?(file_path)
		puts operationOverArray(ARGV[0],file_path)
	else
		puts "Неверное указан файл"
	end
elsif(ARGV[0]=="numberFirstPossitiveElement" || ARGV[0]=="numberPossitiveElement" || ARGV[0]=="firstPossitiveElement") then
	if File.exist?(file_path)
		puts operationOverArray(numberFirstPossitiveElement,file_path)
	else
		puts "Неверное указан файл"
	end
else
	puts " Введеный метод не существует #{ARGV[0]}"
end
