# SEAN MIZERSKI, STM107@PITT.EDU, HOMEWORK 1, 6/3/2019

# function to find duplicate elements and return their indexs
def find_dupes(array)
	indices = Array.new
	array.each{ |elem| 
		indices.push(array.each_index.select{|index|
			array[index] == elem
		})
	}
	indices.reject! {|x| x.size < 2}
	return indices
end

puts "Please enter the name of the encripted text file, and ensure that it is in the same directory as this tool."
puts "hw1file.txt is included and should work"

text_array = Array.new
sanitized_array = Array.new
input = gets.chomp
text_array = File.read(input).chars.push
# downcases the characters and removes non a-z's
text_array.each{ | elem |
	elem.downcase!
	if elem.ord > 96 and elem.ord < 123 then
		sanitized_array.push(elem)
	end
}
diffs = Array.new
array_of_duo = Array.new
array_of_tri = Array.new
array_of_quad = Array.new

# creates an array of all (n) letter adj combos from the sanitized array
sanitized_array.each_cons(2){ | elem | array_of_duo.push(elem.join(""))}
sanitized_array.each_cons(3){ | elem | array_of_tri.push(elem.join(""))}
sanitized_array.each_cons(4){ | elem | array_of_quad.push(elem.join(""))}

# finds repeated instances of substrings and pushes the index distance between them (important for finding gcd)
# also removes one and two instance anomaloies
find_dupes(array_of_tri).each{ | elem | 
		diffs.push(elem[1]-elem[0]) if elem.length > 2
	}
find_dupes(array_of_tri).each{ | elem | 
	diffs.push(elem[1] - elem[0]) if elem.length > 2  		
}
find_dupes(array_of_quad).each{ | elem |
	diffs.push(elem[1] - elem[0]) if elem.length > 2  		
}

gcd_array = Array.new

# finds gcd of the diffs of all 2 elem comboa of diffs (the array of differances) 
diffs.combination(2).each { |elem| gcd_array.push(elem[1].gcd(elem[0]))}
gcd_array.reject! { |elem| elem <= 3 or elem > 30}
# presents the user with an array of gcds for him/her to examine
p gcd_array.sort
puts "Examine the above array. These are the likely values that can possible represent the KEY LENGTH."
puts "If a common factor appears to exist between many of these values, that factor (as long as its IS NOT 1)"
puts "is likely the KEYWORD LENGTH. use this info to further analize the text and crack the KEYWORD"
