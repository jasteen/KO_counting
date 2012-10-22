#!/usr/bin/perl

use strict;
use warnings;
use Bio::TreeIO;


#####
#Written by Jason Steen, Australian Centre for Ecogenomics, 22/10/2012
#This script takes a phylo tree, and outputs the tip labels as a cbind command for R
#Errors/ommisions/suggestions j.steen2@uq.edu.au
####

my $length = @ARGV;
if($length != 2){die "\n\nUSAGE: 'perl cbind_for_R_from_tree <input_file> <Output_path>'\n
You should not include the final backslash on your path\n\n"}

my $files_dir = shift(@ARGV);
my $output_name = shift(@ARGV);

my $input = new Bio::TreeIO(-file => "$files_dir",
                            -format => "newick");

open(OUT, ">$output_name/cbind_from_tree.txt");

my $tree = $input->next_tree;
my @taxa = $tree->get_leaf_nodes;

print OUT "cbind\(";
foreach (@taxa){
    print OUT "a[,'",$_->id,"'], "; 
}
print OUT "\)";

close(OUT);
exit(0);
