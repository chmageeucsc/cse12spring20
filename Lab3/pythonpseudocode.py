# for lab3 in cse12
# basically just pseudocode
#

useIn = int(input("Enter the height of the pattern (must be greater than 0):\t"))

while useIn <= 0 :
    print("Invalid entry!")
    useIn = int(input("Enter the height of the pattern (must be greater than 0):\t"))
# end while

#print("Nice.")

lines = useIn
stars = (lines - 1) * 2
num = 0
count = 0
total = useIn*2

if lines != 0 :
    count = count + 1
    print (count, end = "\t")
    while stars > 0 :
        print ("*", end = "\t")
        total = total - 2
        lines = lines - 1
        stars = stars - 1
    # end while
    print (count)
    count = count - 1
    lines = lines - 1
# end if
