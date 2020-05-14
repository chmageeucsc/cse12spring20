# Lab4 Pseudocode

print('Program arguments:')
inputs = 0
args = []

while inputs != '' :
    inputs = input('')
    if inputs == '' :
        continue
    decimal = int(inputs, 16)
    args.append(inputs)
# end while

print(args)
print()
print('Integer values:')

for i in args :
    
