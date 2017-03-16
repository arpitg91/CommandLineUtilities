#!/usr/bin/env python
import csv, sys

infile = sys.argv[1]
outfile = sys.argv[2]
delimiter=sys.argv[3]

infile = open(infile,'rb')
outfile = open(outfile,'wb')
reader = csv.reader(infile,delimiter=delimiter)
writer = csv.writer(outfile,delimiter=delimiter)

header = reader.next()
writer.writerow(map(lambda x: x.upper().replace('  ','').replace(' ','_'),header))

for row in reader:
    row = map(lambda x: x.replace(delimiter,'').strip().replace('\r',''),row)
    if len(row) == len(header):
        writer.writerow(row)
        
infile.close()
outfile.close()
