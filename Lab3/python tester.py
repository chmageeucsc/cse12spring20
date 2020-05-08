
#rev = 0
#for row in range (1, n+1) :
#    rev = rev + row
#    for col in range (1, row+1) :
#        print (rev, end = "\t")
#        rev = rev - 1
    # end for
#    print()
# end for


#k= 10
#for i in range(4,0,-1):
#    for j in range(i,0,-1):
#        print(k,end="\t")
#        k=k-1
#    print()


n = int(input("number: "))
num = 1
stars = (n-1) * 2
for row in range (1, n+1) :
    mirror = row
    for col in range (1, row+1) :
        print (num, end = "\t")
        num = num + 1
        mirror = num -1
    # end for
    while stars > 0 :
        print ("*", end = "\t")
        stars = stars - 1
    # end while
    n = n-1
    stars = (n-1) * 2
    for col in range (1, row+1) :
        print (mirror, end = "\t")
        mirror = mirror - 1
    # end for
    print()
# end for


#for i in range (1, useIn+1) :
#    for j in range (1, i+1) :
#        print (num, end = "\t")
#        num = num + 1
    # end for
#    print()
# end for



#print("Nice.")

# lines = number of lines in the triangle
#lines = useIn
# stars = number of asterisks in the line
#stars = (lines - 1) * 2
# current line
#curl = 0
# num = number of 
#num = 1
# count = the numbers in each line (ex: 2,3,3,2)
#count = 0
# total = total number of characters in a line
#total = useIn*2

#while lines != 0 :
#    for count in range (0, lines) :
#        count = count + 1
#        print (count, end = "\t")
#        while stars > 0 :
#            print ("*", end = "\t")
#            stars = stars - 1
#        # end while
#        print (count)
#        #count = count - 1
#        lines = lines - 1
#        stars = (lines - 1) * 2



