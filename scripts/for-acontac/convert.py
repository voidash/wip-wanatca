import sys

file = (sys.argv[1])

with open(file,'r', encoding='ISO-8859-1') as f:
    print(f.read())

