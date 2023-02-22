require("prime")

#Дан целочисленный массив. Необходимо найти кол-во эл-в, расположенных после последнего макс\n"
def countElmAfterLastMax(array)
	if(array.length==0) then
		return 0
	end
	array.reverse.index(array.max)
end

#Дан целочисленный массив. Необходимо разместить эл-ты, расположенные до мин, в конце массива \n"
def elemBeforeMinToEndArray(array)
	if(array.length==0) then
		return 0
	end
	beforeMin = Array.new(array.index(array.min)) { |i|  array[i]}
	(array.delete_if{|x| array.index(x) < array.index(array.min) }) + beforeMin
end

#Дан целочисленный массив и интервал (a,b). Необходимо найти макс из элементов в этом интервале \n"
def maxElemInterval(array,a,b)
	if(array.length == 0 || a < 0 or b > array.length) then
		return 0
	end
	array[a..b].max
end

#Дан целочисленный массив. Вывести индексы эл-в, которые меньше своего левого соседа, и кол-во таких чисел\n"
def countElementsLessLeftNeighbor(array)
	b=[]
	array.each_index { |ind| array[ind+1]!= nil and array[ind]>array[ind+1]? b.push(ind+1): 0}
	print b,"\n"
	b.count
end
#print countElementsLessLeftNeighbor([54,56,67,1,78,1,45,7,86743,45,47,1]),"\n"

#Для введенного списка + чисел построить список всех + простых делителей эл-в списка без повторений\n"
def createListAllPossitiveSimpleDivElemListUniq(list)
	temp = Array.new() 
	list.each do |val|
		temp.push(val.prime_division.flatten.uniq.sort)
	end
	temp.flatten.uniq.sort
end

#p createListAllPossitiveSimpleDivElemListUniq([54,43,83,8])

# 1 -- 13 -- 25 -- 37 -- 49 Без циклов , файл или клава
puts " 1 - Дан целочисленный массив. Необходимо найти кол-во эл-в, расположенных после последнего макс\n"
puts " 2 - Дан целочисленный массив. Необходимо разместить эл-ты, расположенные до мин, в конце массива \n"
puts " 3 - Дан целочисленный массив и интервал (a,b). Необходимо найти макс из элементов в этом интервале \n"
puts " 4 - Дан целочисленный массив. Вывести индексы эл-в, которые меньше своего левого соседа, и кол-во таких чисел\n"
puts " 5 - Для введенного списка + чисел построить список всех + простых делителей эл-в списка без повторений\n"
puts " Выбор: "
task = STDIN.gets.chomp
puts " Считать с файла - 1? "
chooseInputUser = STDIN.gets.chomp
file_path = ""
array = Array.new
if(chooseInputUser == "1") then
	puts " Введите name file\n"
	addressFile = STDIN.gets.chomp
	current_path = File.dirname(__FILE__)
	file_path = current_path + "/" + addressFile
	array = (File.open(file_path,'r'){|file| file.read}).split(' ').map{|item| item.to_i}
else
	puts " Введите массив чисел через пробел \n"
	array = STDIN.gets.chomp.split.map { |s| s.to_i}
end

p array

if(task=="1") then
	p countElmAfterLastMax(array)
elsif(task=="2") then
	p elemBeforeMinToEndArray(array)
elsif(task=="3") then
	p maxElemInterval(array)
elsif(task=="4")then
	p countElementsLessLeftNeighbor(array)
elsif(task=="5") then
	p createListAllPossitiveSimpleDivElemListUniq(array)
else
	puts "Ни один метод не выбран!"
end