THIS=`basename $0`
err_msg="Usage: cat mst_file|$THIS <-n colums> <-t dlm> [-r] [-v]
      -n :  column names to be selected. Seperated by comma;
      -f :  file list, one row one name. This option will overwrite option -n;	  
            note: the file can be multiple columns, seperated by value in -t option
                  the first column will be used as the name;
      -v :  output the columns not in -n/-f option;
      -r :  regular expression in -n option, e.g., \"-n CID,^F_BR_,_L1M$ -r \" ;
            note: only support head(\"^\") and tail(\"$\") in expression; 
      -t :  delimitor for input file, default ~ ;
      -p :  print log ;
      Example cat fin.csv | cut_by_name.sh -n aaa,bbb,ccc  -t, "


export DLM='~'
export NFILE="none"
export RVS=0
export REG=0
export PRINT_LOG=0

while getopts "n:f:t:prvh" OPTION
do
    case $OPTION in
    n)  export NAMES=$OPTARG;;
	f)  export NFILE=$OPTARG;;
    t)  export DLM=$OPTARG;;
    v)  export RVS=1;;
    r)  export REG=1;;
    p)  export PRINT_LOG=1;;
    h)  echo "$err_msg" >&2
            exit 1;;
    ?)  echo "$err_msg" >&2
            exit 2;;
    esac
done

if [ -s ${NFILE}  ]; then
	NAMES=`cat ${NFILE}|cut -d "${DLM}" -f 1| tr "\n" "," `
fi


sed 's/\r//g' |awk -F${DLM}  -v DLM=${DLM}  -v names=${NAMES} -v rvs=${RVS} -v reg=${REG} -v plog=${PRINT_LOG}\
      'function check(out_col,j,nm) {\
                if(out_col=="") {printf("error in selected field %d: %s\n",j,nm) >"/dev/stderr"; exit 100;}}\
       function get_expr(nm_str,header) {\
         grep_str="|"; \
         tmp_str=nm_str;  gsub(/,/,grep_str,tmp_str);  \
         cmd=sprintf("echo  \"%s\"|tr \"%s\" \"\\n\"|grep -E \"%s\" |tr \"\\n\" \"%s\" |sed \"s/%s$/\\n/g\" " \
                        ,header,DLM,tmp_str,",",",");\
         cmd|getline new_names; \
         return new_names;}\
    { OFS=DLM; ORS=DLM;cnt=0; rord=0;\
       if(NR==1) {\
            if(reg==1) {new_names=get_expr(names,$0);} 
            else {new_names=names};
            split(new_names,nm_lst,","); 
            for(i=1;i<=length(nm_lst);i++) {
                nm=nm_lst[i]; nm_dict[nm]=i;};   \
            \
            \
            for(j=1;j<=NF;j++) { \
              if(nm_dict[$j]!="") {ord=nm_dict[$j]; out[ord]=j; if(plog) printf("%d:%s\n",j,$j) >"/dev/stderr" ;}  \
              else {rord+=1;; rout[rord]=j;}}};  \
       if(rvs==0) {for(j=1;j<=length(out);j++) {out_col=out[j]; \
                                    check(out_col,j,nm_lst[j]);\
                                    print $out_col ;};printf("\n");}
       else {for(j=1;j<=length(rout);j++) {out_col=rout[j]; \
                                    check(out_col,j,nm_lst[j]);\
                                    print $out_col ;};printf("\n");}
      }'|sed "s/"${DLM}"$//g" 
        
