# 1 -- 13 -- 25 -- 37 -- 49 Без циклов , файл или клава
=begin puts " 1 - Дан целочисленный массив. Необходимо найти кол-во эл-в, расположенных после последнего макс\n"
puts " 2 - Дан целочисленный массив. Необходимо разместить эл-ты, расположенные до мин, в конце массива \n"
puts " 3 - Дан целочисленный массив и интервал (a,b). Необходимо найти кол-во эл-в, расположенных первым и последним мин\n"
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
a = [1,6,4,5,23,6,7,23,4,6]
print  countElmAfterLastMax(a)