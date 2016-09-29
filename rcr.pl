#!/usr/perl

# Files for assembly
my vectorTrimfiles =
my sff_file =

# Paramters for assembly
my min_length =
my min_overlap =
my min_overlap_id =
my expected_seq_len = 1000000

#
my file ="mid6.fastq";
my iter_times = 100
my @x_coverage = ("5,10,20,30,40,50");

my record_count =`wc -l $file`;
chomp record_count
###############################################################################
sub run_Assembly {
#put together intial argumets to pass to runAssembly
my @paravals_internal = @_;

#default arguments to run
my @args_def= ('-o',"$paravals_internal[0]",
  '-force',
  #'-m',
  '-cpu','0',
  '-nobig',
  '-vs',$vectorTrimfiles,
  '-vt',$vectorTrimfiles,  # hard code.....
  $sff_file # rework code to take in fastq 
  ); # hard code.....

# relabel out from para_combo_gen to paravals


#set up parameters to pass into system
my @para_args=(
	'-minlen',"$paravals_internal[1]",
	#Minimum length of reads to use in assembly Default: 50 Min: 15

	'-ss','1',
	#Set seed step parameter must be >=1

	'-sl','10',
	#Set seed length parameter 6 to 15

	'-sc','10 ',
	#Set seed count parameter must be >=1

	'-ml',"$paravals_internal[2]",
	#Set minimum overlap must be >=1

	'-mi',"$paravals_internal[3]",
	#Set minimum overlap identify 0 to 99
);
print"running $runAssembly with:\n
@para_args and @args_def \n\n";
system($runAssembly,@para_args,@args_def);

#convert array of parameters to string
#@string_para_args= joing(",",@para_args);

#output string paras and folder name
@runAssembly_paras=($paravals_internal[0],@para_args);

return @runAssembly_paras;
}

###############################################################################

for my $iter_num (0..$iter_times){
  for my $x (@x_coverage){
    # calc number of records for coverage
    my cal_cov = $record_count/$x;
    my foldername = "mid6_cov_" . $x . "_iter" . $iter_num . ".fastq";
    system("sed -n 1~4p $file | shuf -n $cal_cov > $foldername");
    my foldername = "mid6_cov_" . $x ."_iter" . $iter_num;

    my @all_paramters =($foldername, $min_length, $min_overlap, $min_overlap_id);
    run_Assembly(@all_paramters);

  }
}

# From: Estimating Sequencing Coverage
# http://www.illumina.com/content/dam/illumina-marketing/documents/products/technotes/technote_coverage_calculation.pdf
## C = LN / G
#• C stands for coverage
#• G is the haploid genome length
#• L is the read length
#• N is the number of reads

 C= LN/G
 c/G=LN
 (c/g)/L = N
