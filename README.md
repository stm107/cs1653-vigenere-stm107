Sean Mizerski
stm107

When I first approached the encrypted text, it looked to me like it was probably a vignere cipher and there were a few obvious places where I could guess what the decoded plaintext was. For example, there was a place that looked like it had "cs1653". I also guessed that the first world was probably "Congratulations!" based on the punctuation and number of characters. 

I then implemented the Kasiski algorithm in Ruby. First, my program asks the user to enter in the filename of a file that contains the cipher text. Then it reads in that file, removes all of the non-alpha characters, and looks for duplicate substrings of length 2, 3, and 4. It calculates the differences between the indices of these repeated substrings, and then find the GCDs of all of the differences. Finally, thee program prints the array of GCDs as probably keyword lengths, with the mode being the most likely key word length. When I ran this program, I got that the keyword was likely 7 characters long.

Then, I implemented a program that deocdes the entire cipher based on the cipher text, the known plaintext ("Congratulations!") and the probably length of the key. Like the Kasiski program, it santizes the ciphertext to remove all non-alpha characters. Using the known text, the cipher text, and the key length, it produces the correct key. It then uses that key to decode the entire message. Because, as we learned in class, the computer has no real way of knowing if the deciphered text is correct or not, my program then asks the user if it looks right, and gives them the option to try again if it doesn't.

The user should run the Kasiski program first. This is run with ruby kasiski_alg.rb. Then, armed with the probably key length, the user can run the decoder with ruby decryptor.rb. 

There is an inclued text document that contains the ciphertext that was provided on courseweb for passing into the programs. It is called hw1file.txt. There is also a PDF with some additional thorught and notes on my process for solving the cipher including my process for decoding the word "Congratulations!" at the beginning of the ciphertext.  