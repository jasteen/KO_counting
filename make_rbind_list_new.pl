#!/usr/bin/perl

use strict;
use warnings;

#####
#Written by Jason Steen, Australian Centre for Ecogenomics, 22/10/2012
#This script takes an ordered list of KO names, and converts it into an rbind command for use in R when making heatmaps based on KO counts
#Errors/ommisions/suggestions j.steen2@uq.edu.au
####

my $length = @ARGV;
if($length != 2){die "\n\nUSAGE: 'perl make_rbind_list_new.pl <input_file> <Output_path>'\n
You should not include the final backslash on your path\nThis script expects the KO names to be in the first column (column 0)\n\n"}

my $files_dir = shift(@ARGV);
my $output_name = shift(@ARGV);


open(IN, "$files_dir");

open(OUT, ">$output_name/rbind_line_for_R.txt");

print OUT "rbind\(";

while(<IN>){
    chomp;
    my @temp = split(/\t/, $_);
    #$temp[0] =~ s/KO://;
    print OUT "a['$temp[0]',], "; 
}


print OUT "\)";

close(IN);
close(OUT);
exit(0);