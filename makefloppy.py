#!/usr/bin/python
import sys


sector_size = 512
magic = '\x55\xaa'
padding = '\x00'

f = open(sys.argv[1], "rb")
data = f.read()
f.close()

align = sector_size - len(data) - 2

with open('floppy.bin', 'wb') as output:
    output.write(data)
    output.write(padding * align + magic)

