#1Task
puts "Hello world!"
#2Task
nameUser = ARGV[0]
puts "Hello, #{ARGV[0]}"
puts "Your favority language?"
favoriteLanguage = STDIN.gets.chomp
if (favoriteLanguage == "Ruby" || favoriteLanguage == "ruby") then
	puts "You bad programmer"
else
	puts "Good,good!"
end
#Task3
puts "Input command Ruby:"
commandRuby = STDIN.gets.chomp
puts "Input command OS(Linux)"
commandLinux = STDIN.gets.chomp
puts "Execution ruby.."
system "ruby -e \'#{commandRuby}\'"
puts "Execution OS.."
system commandLinux
