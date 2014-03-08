File.open("names2.txt", "w") { |f| f.puts File.readlines("names.txt").map(&:downcase).join }

