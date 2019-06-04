# SEAN MIZERSKI, STM107@PITT.EDU, HOMEWORK 1, 6/3/2019

# This function gets the know text substring and the encrypted text that coorsponds to it, from the user.
def key_crack()
	# on input the user text is downcased and then converted to its ascii value.
	puts "Please enter the known text"
	in_temp = Array.new
	known_word = Array.new
	in_temp = gets.chomp.downcase.chars
	$orgional_known_word = in_temp.join("").to_s
	in_temp.each{ | c | 
		y = c.ord
		known_word.push(y)
	}
	in_temp.clear
	puts "Now, enter the coorsponding encrepted text"
	encrypted_word = Array.new
	in_temp = gets.chomp.downcase.chars
	in_temp.each{ | c | 
		y = c.ord
		encrypted_word.push(y)
	}
	in_temp.clear
	raw_key_array = Array.new
	n = 0
	# sanitizes the keyword from non a-z chars, and upcases the output, pushes output an array
	while n < known_word.length do
		if known_word[n] > 96 and known_word[n] < 123 then
			key_char = ((encrypted_word[n] - 97) - (known_word[n] - 97)) % 26
			key_char += 97
			key_char = key_char.chr.upcase 
			raw_key_array.push(key_char)
			n += 1
		else
			n += 1
		end
	end
	# prior to running this program the user should have run a kasiski anaylsis to find the keyword length
	# this is used to take only one instance of the keyword (any order) from the array containing the keyword
	puts "Please enter the KEYWORD length (possibly found via kasiski anaylsis)"
	key_length = gets.chomp.to_i
	return raw_key_array[0..(key_length - 1)]
end

# uses the key to decrypt the cypher text. key_count is mod by the length of the keyword to achive the circular iteration of the key as we iterat through the text 
def decoder(key_count, cypher, key_array)
	cypher = cypher.downcase.ord
	key_length = key_array.length
	# gotta be 0 - 25
	if cypher.ord > 96 and  cypher.ord < 123 then
		cypher = cypher.ord - 97
		key_count %= key_length
		x = key_array[key_count].downcase.ord - 97
		# decode and back to ascii
		text = (cypher - x) % 26 + 97
		return text.chr.upcase
	else 
		return cypher.chr
	end
end

# main method 
key = Array.new
key = key_crack()
key_count = 0
bar = 1
# gets the file to decode
puts "Please type the encrypted file name and ensure it's in the SAME directory as decryptor.rb."
puts "hw1file.txt should be included in the repository"
text_array = Array.new
decrypted_array = Array.new
input = gets.chomp
# parses the text file to an array of chars
text_array = File.read(input).chars.push
# loop to present the user with one of n = (KEYWORD LENGTH) possible solutions
# the user responds as to weather the messsage is english or not.
# if not, we try the next orientation 
while bar == 1 do
	text_array.each do | cypher |
			decrypted_array.push(decoder(key_count, cypher, key))
			key_count += 1 if cypher.downcase.ord > 96 and cypher.downcase.ord < 123
	end
	puts "\n" + decrypted_array.join("") + "\n\n\n"
	puts "It's all 1's and 0's to me... is this your message? press 0 if yes, 1 to try again, or anything else to exit"
	bar = gets.chomp.to_i
	decrypted_array.clear
end

puts "Bye!!"
