#!/usr/bin/perl

use warnings;
use strict;

my $length = @ARGV;
if($length != 3){die "\n\nUSAGE: 'perl subset_KO_table_by_all_lists_new.pl <Path_to_KO_lists> <counts_file> <Output_Directory>'\n
You should not include the final backslash on your path\nEG: 'perl subset_KO_table_by_all_lists_new.pl ~/Genome_KOs/KO_lists ~/Genome_KOs/counts.file ~/GenomeKOs/new_directory\n\n"}

my $base_dir_list=shift(@ARGV);
my $count_file = shift(@ARGV);
my $output_directory = shift(@ARGV);

my @all_files = glob("$base_dir_list/*.txt");

foreach my $file (@all_files){
    my @name= split(/\//, $file);
    my $temp_name = pop(@name);
    $temp_name =~ s/\.txt//;
    open(IN, "$file") or die "I died because $!\n";
    
    my %data;
    while(<IN>){
        chomp;
        $data{$_} = $_;
    }
    
    close(IN);
    open(IN2, "$count_file") or die "I died because $!\n";
    
    my $header = <IN2>;
    
    my $total=0;
    my $filtered=0;
    my @temp_array=();
    while(<IN2>){
        $total++;
        chomp;
        my @temp = split(/\t/, $_);
        $temp[0]=~ s/KO://;
        if(exists($data{$temp[0]})){
            push(@temp_array, $_);
            $filtered++;
        }else{next}
        #print STDOUT @temp_array;
    if($filtered >= 1){
        open(OUT, ">$output_directory/$temp_name.counts.txt") or die;
        print OUT "$header";
        foreach my $line (@temp_array){
            print OUT "$line\n";
        }
    } else {
        next;
        }
    }    
    
    print STDOUT "$total pathways were present in initial file, of which $filtered are in $temp_name\n";
    
    
    close(IN2);
    close(OUT);
}
exit(0);
