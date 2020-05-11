# for lab3 in cse12
# basically just pseudocode
#

useIn = 4 #int(input("Enter the height of the pattern (must be greater than 0): "))

while useIn <= 0 :
    print("Invalid entry!")
    useIn = int(input("Enter the height of the pattern (must be greater than 0): "))
# end while

print()

num = 1
stars = (useIn-1) * 2
for row in range (1, useIn+1) :
    for col in range (1, row+1) :
        print (num, end = "\t")
        num = num + 1
        mirror = num - 1
    # end for
    while stars > 0 :
        print ("*", end = "\t")
        stars = stars - 1
    # end while
    useIn = useIn-1
    stars = (useIn-1) * 2
    for col in range (1, row) :
        print (mirror, end = "\t")
        mirror = mirror - 1
    # end for
    for col in range (row, row+1) :
        print (mirror)
    print()
# end for
