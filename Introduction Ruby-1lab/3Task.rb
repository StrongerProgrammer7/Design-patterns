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
puts minElement([1,2,0,4,1])
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
	return -1;
			
end

puts numberFirstPossitiveElement([-1,2,-3,5])