# for lab3 in cse12
# basically just pseudocode
#

useIn = int(input("Enter the height of the pattern (must be greater than 0): "))

while useIn <= 0 :
    print("Invalid entry!")
    useIn = int(input("Enter the height of the pattern (must be greater than 0):\t"))
# end while

#print("Nice.")

# lines = number of lines in the triangle
lines = useIn
# stars = number of asterisks in the line
stars = (lines - 1) * 2
# current line
curl = 0
# num = number of 
num = 1
# count = the numbers in each line (ex: 2,3,3,2)
count = 0
# total = total number of characters in a line
total = useIn*2

while lines != 0 :
    curl = curl + 1
    for count in range (0, curl) :
        count = count + 1
        print (count, end = "\t")
        while stars > 0 :
            print ("*", end = "\t")
            stars = stars - 1
        # end while
        print (count)
        count = count - 1
        lines = lines - 1
        stars = (lines - 1) * 2

for i in range (1, useIn+1) :
    for j in range (1, i+1) :
        print (num, end = "\t")
        num = num + 1
    # end for
    print()
# end for
