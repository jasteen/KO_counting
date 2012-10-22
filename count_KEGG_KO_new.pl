#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

my $length = @ARGV;
if($length != 4){die "\n\nUSAGE: 'perl count_KEGG_KO.pl <Path_to_input_files> <Output_file_prefix> <column containing Kegg pathways> <column containing counts>'\n
You should not include the final backslash on your path\nColumn numbers are 0 indexed\n\nEG: 'perl count_KEGG_KO_new.pl ~/Genome_KOs my_project 0 3\n\n"}

my $files_dir = shift(@ARGV);
my $output_name = shift(@ARGV);
my $name_column = shift(@ARGV);
my $count_column = shift(@ARGV);

my @filelist = glob("$files_dir/[A|C]*");

my %data;

open(OUT, ">$files_dir/$output_name.KO.counted.txt") or die "cannot open $!";

print OUT "KO_Number\t";

foreach my $file(@filelist){
    my @temp_name = split(/\//, $file);
    my $file_name = pop(@temp_name);
    print STDOUT "$file_name\n";
    my @temp_name_2 = split(/\./, $file_name);
    my $final_name = shift(@temp_name_2);
    print OUT "$final_name\t";
    open(IN, $file);
    while(my $line = <IN>){
        chomp($line);
        if ($line =~ /^KO:/){
            $line =~ s/KO\://;
            my @temp = split(/\t/, $line);
            $data{$temp[$name_column]}{$file} = $temp[$count_column];
        }            
            
    }
close(IN);    

}
print OUT "\n";


my @values;
foreach my $keys (keys %data){
        push(@values, $keys)
}


foreach my $key(@values){
    print OUT "$key\t";
    foreach my $files(@filelist){
        if(exists($data{$key}{$files})){
            print OUT "$data{$key}{$files}\t";
        }else{
            print OUT "0\t";
        }
    }
    print OUT "\n";
}

#print Dumper(%data);
close(IN);
close(OUT);
exit(0);
