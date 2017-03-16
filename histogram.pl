
use Getopt::Long;

$usage = "$0 [options]\n".
 "Outputs histogram for readings from STDIN.\n".
 "Options: \n".
 "\t --help. \n".
 "\t --f sorts by frequency, not key. \n".
 "\t --n assumes inputs are numeric. \n".
 "\t --b=bin uses bin size (bin) - should be used only for numeric inputs. \n".
 "\t --l=num prints out only first n fields (value, count, pct., cum.pct., 1-cum.pct.) \n".
 "\t --t output tab delimited instead of comma delimited. \n".
 "\t --h prints out column headings. \n\n";


@optl = ("help","f","n","b=f", "l=i", "t", "h");
die $usage unless GetOptions(@optl);

die $usage if($opt_help);

$total = 0;
$biggest = 0;
while ($line = <STDIN>) {
  chomp($line);
  if (($opt_n) or ($opt_b)) {
    $line =~ s/ //g;
    if($#line > $biggest) {
      $biggest = $#line;
    }
  }
  if ($opt_b) {
    $line = $opt_b * int($line/$opt_b +1);
  }
  $hist{$line}++;
  $tot++;
}

$cumu = 0;
if($opt_f) {
  @sort_key = sort {$hist{$b} <=> $hist{$a}} keys(%hist);
} elsif($opt_n) {
  @sort_key = sort {$a<=>$b} keys(%hist);
} else {
  @sort_key = sort {$a cmp $b} keys(%hist);
}

$delim="|";
if($opt_t) {
  $delim="\t";
}

$fields = 5;
if($opt_l) {
  $fields = $opt_l;
}

if($opt_h) {
  printf("Value");
  if($fields>1) { 
    printf("$delim Count");
    if($fields>2) {
      printf("$delim Pct.");
      if($fields>3) {
        printf("$delim CumPct");
        if($fields>4) {
          printf("$delim 1-CumPct")
        }
      }
    }
    printf("\n");
  }
}

foreach $key (@sort_key) {
  $cumu += $hist{$key};
  $tmp = 100*$cumu/$tot;
  printf("$key");
  if($fields>1) {
    printf("$delim %d", $hist{$key});
    if($fields>2) {
      printf("$delim %.2f%%", 100*$hist{$key}/$tot);
      if($fields>3) {
        printf("$delim %.2f%%", $tmp);
        if($fields>4) {
          printf("$delim %.2f%%", 100-$tmp);
        }
      }
    }
  }
  printf("\n");
}
