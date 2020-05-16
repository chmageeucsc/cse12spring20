##################################
#PSEUDOCODE
##################################

print "program arguments"
pa loop
if $a1 = 0, move on to integer values
else, print argument
store argument
check next argument - another pa loop
 
"integer values"
(ascii to hex)
check if first byte (after 0x) is letter or number
letter:
load byte
convert to hex value
store and shift to make space for next value
next byte - loop back to check
number
load byte
convert to hex value
store and shift to make space for next value
next byte - loop back to check

repeat checks with next ascii/hex

(hex to int)
use syscall 1 to print as int

repeat with next hex/int

"sorted values
sorting
compare first stored value (a) to second (b
if a > b, swap values
parse through all values until sorted

print out sorted values
