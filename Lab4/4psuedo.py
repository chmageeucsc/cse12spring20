# Lab4 Pseudocode

#print('Program arguments:')
#inputs = 0
#args = []

#while inputs != '' :
#    inputs = input('')
#    if inputs == '' :
#        continue
#    decimal = int(inputs, 16)
#    decimal = str(decimal)
#    args.append(inputs)
# end while

#print(args)
#print()
#print('Integer values:')

#for i in len(args) :
#    print(args[i])
#    i += 1

num = 0
leest = []
while num != '' :
    num = input('')
    if num == '':
        continue
    leest.append(num)
print(leest)

for i in leest :
    print(int(i))
