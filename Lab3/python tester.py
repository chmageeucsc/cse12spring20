
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
    for col in range (1, row+1) :
        print (num, end = "\t")
        num = num + 1
    # end for
    while stars > 0 :
        print ("*", end = "\t")
        stars = stars - 1
    # end while
    n = n-1
    stars = (n-1) * 2
    print()
# end for


#for i in range (1, useIn+1) :
#    for j in range (1, i+1) :
#        print (num, end = "\t")
#        num = num + 1
    # end for
#    print()
# end for
