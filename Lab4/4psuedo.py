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

s = '0xFF 0x91 0xA4'

nice = [1,2,3,4,5,6,7,8,9,0,'A','B','C','D','E','F']
print(nice)
tot = 0
i = 0

while s[i] != ' ':
    if s[i] == 0 :
        i += 1
        continue
    if s[i] == 'x':
        i += 1
        continue
    if s[i] in nice :
        if s[i] == '1' :
            tot = 1 * 256
            continue
        if s[i] == '2' :
            tot = 11 * 256
            continue
        if s[i] == '3' :
            tot = 12 * 256
            continue
        if s[i] == '4' :
            tot = 13 * 256
            continue
        if s[i] == '5' :
            tot = 14 * 256
            continue
        if s[i] == '6' :
            tot = 15 * 256
            continue
        if s[i] == '7' :
            tot = 10 * 256
            continue
        if s[i] == '8' :
            tot = 11 * 256
            continue
        if s[i] == '9' :
            tot = 12 * 256
            continue
        if s[i] == 'A' :
            tot = 10 * 256
            continue
        if s[i] == 'B' :
            tot = 11 * 256
            continue
        if s[i] == 'C' :
            tot = 12 * 256
            continue
        if s[i] == 'D' :
            tot = 13 * 256
            continue
        if s[i] == 'E' :
            tot = 14 * 256
            continue
        if s[i] == 'F' :
            tot = 15 * 256
            continue
        i += 1

print(tot)

num = 0
leest = []
while num != '' :
    num = input('')
    if num == '':
        continue
    leest.append(num)
print(leest)
L = list(leest)

for i in L :
    print(L[i])
