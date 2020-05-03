# for lab3 in cse12
# basically just pseudocode
#

useIn = int(input("Enter the height of the pattern (must be greater than 0):\t"))

while useIn <= 0 :
    print("Invalid entry!")
    useIn = int(input("Enter the height of the pattern (must be greater than 0):\t"))
# end while

#print("Nice.")

# lines = number of lines in the triangle
lines = useIn
# stars = number of asterisks in the line
stars = (lines - 1) * 2
# num = number of 
num = 0
# count = numbers in each line (ex: 2,3,3,2)
count = 0
# total = total number of characters in a line
total = useIn*2

while lines != 0 :
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
