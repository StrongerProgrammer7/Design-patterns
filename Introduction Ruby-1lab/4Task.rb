# 1 -- 13 -- 25 -- 37 -- 49 Без циклов , файл или клава
=begin puts " 1 - Дан целочисленный массив. Необходимо найти кол-во эл-в, расположенных после последнего макс\n"
puts " 2 - Дан целочисленный массив. Необходимо разместить эл-ты, расположенные до мин, в конце массива \n"
puts " 3 - Дан целочисленный массив и интервал (a,b). Необходимо найти макс из элементов в этом интервале \n"
puts " 4 - Дан целочисленный массив. Вывести индексы эл-в, которые меньше своего левого соседа, и кол-во таких чисел\n"
puts " 5 - Для введенного списка + чисел построить список всех + простых делителей эл-в списка без повторений\n"
puts " Выбор: "
task = STDIN.gets.chomp
puts " Считать с файла - 1 или клавиатура - 0 "
chooseInputUser = STDIN.gets.chomp
file_path = ""
array =""
if(chooseInputUser == 1) then
	puts " Введите путь в текущей директории (без /)\n"
	addressFile = STDIN.gets.chomp
	current_path = File.dirname(__FILE__)
	file_path = current_path + "/" + current_path
else
	puts " Введите массив чисел через пробел \n"
	array = STDIN.gets.chomp
	array.split(' ').map{|item| item.to_i}
end
=end
def countElmAfterLastMax(array)
	if(array.length==0) then
		return 0
	end
	return array.reverse.index(array.max)
end

def elemBeforeMinToEndArray(array)
	if(array.length==0) then
		return 0
	end
	beforeMin = Array.new(array.index(array.min)) { |i|  array[i]}
	return (array.delete_if{|x| array.index(x) < array.index(array.min) }) + beforeMin
end

def maxElemInterval(array,a,b)
	if(array.length == 0 || a < 0 or b > array.length) then
		return 0
	end
	return array[a..b].max
end

a = [54,56,67,68,78,32,45,7,86743,45,47]
print maxElemInterval(a,1,10)