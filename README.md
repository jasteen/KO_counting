KO_counting
===========

for counting and plotting KO groups of multiple organisms

This selection of scripts is designed to make tables of KO counts from IMG style KO counts tables

usage:

1. Make a tree using the genome_tree_database.  Around 50 genomes is a good number to display on a single A4 page.
2. Go to IMG, and download the KO counts for each of the genomes in your tree.  Save each as an individual text file in a new directory for this project somewhere.  At the moment, the script requires the names of the files to match the ACE internal genome name from the database (ie, A00000012, C00000001).
3. Run count_KEGG_KO_new.pl on this folder
4. Run subset_KO_table_by_all_lists_new.pl on the output of (3).
5. Run cbind_for_R_from_tree.pl on your tree (make sure you outgroup your tree, and make sure its in a format you are happy with (ARB or figtree can help with this)). Must be in newick format.
6. Open generic_R_heatmaps_for_KO_tables.R in R or RStudio (I love RStudio, and you will too).  modify the places that need mofidying, and make your heatmaps.
7. Profit (significant profits may be taxed in coffee or lollies should these scripts be useful)

