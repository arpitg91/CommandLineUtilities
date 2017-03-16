dlm=$1
awk -F "${dlm}" '{print NF}' |histogram.pl
