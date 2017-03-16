# append_files.py

### Description
Concats multiple files with same or different schemas. Files output in order of input arguments.Header sequence output in sequence of header of input files

### Usage 
append_files.py [-h] [--ifile IFILE] [--ofile OFILE] [--d D]

arguments:

  -h, --help     show this help message and exit
  --ifile IFILE  Input files split by |
  --ofile OFILE  Output file
  --d D          Delimiters of input file split by ~. Default: Comma"
  
### Example  
python append_files.py --ifile 'fileA|fileB|fileC' --ofile outfile.csv --d ',~,~,'
python append_files.py --ifile 'fileA|fileB|fileC' --ofile outfile.csv --d ','

# clean_file.py
# column_freqs.py
# split_file.py
