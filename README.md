# append_files.py

### Description
Concats multiple files with same or different schemas. Files output in order of input arguments.Header sequence output in sequence of header of input files

### Usage 
python append_files.py [-h] [--ifile IFILE] [--ofile OFILE] [--d D]

### Arguments
  -h, --help     show this help message and exit
  
  --ifile IFILE  Input files split by |
  
  --ofile OFILE  Output file
  
  --d D          Delimiters of input file split by ~. Default: Comma
  
### Example  
python append_files.py --ifile 'fileA|fileB|fileC' --ofile outfile.csv --d ',~,~,'

python append_files.py --ifile 'fileA|fileB|fileC' --ofile outfile.csv --d ','

# clean_file.py

### Description
Removes non printable characters from the file

### Usage 
python clean_file.py infile outfile ','

# column_freqs.py

### Description
Make frequency file for each column present in the input file

### Usage 
python column_freq.py file1 ','

# split_file.py

### Description
Splits a huge file into multiple partitions. By default, the split is random. Additionally, specifying key columns ensures that partitions are based on that key columns. All the key-values are output in same partition. 

E.g. Customer ID is the jey column => All entries of customer A present in the same partition.

### Usage 
python split_file.py [-h] [--ifile IFILE] [--ofile OFILE] [--d D][--chunks CHUNKS] [--samplingCols SAMPLINGCOLS]

### Arguments
  -h, --help            show this help message and exit
  
  --ifile IFILE         Input file
  
  --ofile OFILE         Output file. Default: Input name with suffix.
  
  --d D                 Delimiter. Default: Comma
  
  --chunks CHUNKS       Number of Output Files. Default: 10
  
  --samplingCols SAMPLINGCOLS       Sampling Columns separated by |. Default: None
### Example  
python append_files.py --ifile file1

python append_files.py --ifile file1 --ofile outfile.csv

python append_files.py --ifile file1 --ofile /dir1/dir2/outfile.csv --chunks 10 

python append_files.py --ifile file1 --samplingCols 'CUSTID1|CUSTID2' --d '|'

# check_col.sh

### Description
Count Number of columns in all rows of a file. To be usable for other UNIX Commands, the file should same number of columns in all the rows. In case a cell value also contains delimiter, clean the file using cleantext tool.

### Usage 
pipe the stream into check_col.sh followed by delimiter

### Example  
cat filename | check_col.sh ','

# cut_by_name.sh
### Description
Cut one/multiple columns from unix input stream
### Usage 
cut_by_name.sh -t delimiter -n 'columns separated by ,'
### Example  
cat filename | cut_by_name.sh -t "|" -n "COL1,COL2" | historgram.pl

# histogram.pl

### Description
Get frequency count of an input stream in UNIX pipe operations

### Usage 
Pipe the stream into histogram.pl

### Example  
cat filename | cut -d\| -f1 | histogram.pl

cat filename | cut_by_name.sh -t ""|"" -n ""COL1,COL2"" | historgram.pl
