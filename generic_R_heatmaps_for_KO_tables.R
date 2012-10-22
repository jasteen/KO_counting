##### General R heatmaps for KO counts tables #########
library("ape")
library("RColorBrewer")
library("gplots")
library("ggplot2")
#read the table (INSERT THE TABLE THAT YOU WANT TO READ IN HERE!!!!!)
a <- read.table("<your_counts_table>", sep="\t", header=T, row.names=1)
#remove the last column that contains no data (this is still an error that my current script generates.  havent worked out how to fix it yet)
a <- a[,1:(dim(a)[2])-1]


#IF YOU ARE ORDERING BY ROWS (KO#s), PASTE THE RBIND LINE HERE AND UNCOMMENT
#a <- rbind(a['K01424',], a['K00926',], a['K01953',], a['K01744',], a['K01674',], a['K01725',], a['K01673',], a['K00285',], a['K01455',], a['K00605',], a['K00262',], a['K01915',], a['K01425',], a['K00264',], a['K00265',], a['K00266',], a['K00284',], a['K00261',], a['K01745',], a['K05601',], a['K01916',], a['K00367',], a['K00370',], a['K00371',], a['K00373',], a['K02585',], a['K02586',], a['K02587',], a['K02588',], a['K02589',], a['K02590',], a['K02591',], a['K02593',], a['K02594',], a['K02595',], a['K02596',], a['K02597',], a['K00366',], a['K00362',], a['K00363',], a['K00372',], a['K01501',], a['K00368',], a['K00459',], a['K04561',], a['K00376',], a['K04015',], a['K14155',], a['K10775',], a['K01668',]) 

#IF YOU ARE ORDERING BASED ON YOUR PHYLO TREE, PASTE THE CBIND LINE HERE AND UNCOMMENT
#b <- cbind(a$A00000079, a$A00001271, a$A00000604, a$A00000579, a$A00000836, a$A00001041, a$C00000092, a$C00000008, a$A00000108, a$A00000527, a$A00000287, a$A00000286, a$A00000291, a$A00000292, a$A00000593, a$A00000299, a$A00000793, a$A00000679, a$A00000294, a$A00001644, a$A00001049, a$A00000923, a$A00000794, a$A00000648, a$A00000792, a$A00001208, a$A00000665, a$A00000186, a$A00001053, a$A00000731, a$A00001188, a$A00000308, a$A00001377, a$A00000197, a$A00000466, a$A00000620, a$A00000199, a$A00000198, a$A00000468, a$A00000573, a$A00000465, a$A00000464, a$A00000196, a$A00000200, a$A00000467, a$A00000289, a$A00000290, a$A00000293, a$A00000288, a$A00000528)

#read in the tree to grab names for columns
g <- read.tree("<your_newick.tree>")
#add back the row and column names
colnames(b) <- g$tip.label
rownames(b) <- rownames(a)

#generate Col side colors from levels in list
#Currently takes the third column from the table you used to define the order of the columns.
#If you are self ordering, comment out and remove ColSideColors=csc from the heatmap line

col.levels <- read.table("<your_filename_here>", header=F, sep="\t")
col.levels.list <- as.vector(col.levels[,3])

#define palete of colors to be used for the ColSideColors
#the number in this line is the number of categories you have.  it needs to be modified manually
z <- brewer.pal(3, "Purples")
csc <- c(z)[col.levels.list+1]


#define the colors that will be used for the RowSideColors
#To add a colour bar for the genome names, you need to come up with a vector based on your tree that determines which group each falls into.
#these lines define what I did for Rochelles project.
#if you dont want pretty colors, remove "RowSideCols=rsc" from the heatmap line

#row.levels <- read.table("<your_list_of_categories_here>", header=F, sep="\t")
#row.levels.list <- as.vector(row.levels[,1])
#rsc <- c(Chloroflexi="#EDF8E9", '4C0d-2'="#C7E9C0", Gloeobacterales="#A1D99B", Synechococcales="#74C476", Chroococcales="#41AB5D", Nostocales="#238B45", Oscillatoriales="#005A32")[row.levels.list]

#change the output to include the gene name instead of the KO number.  for this to work, your list of KO numbers must have the gene names in the second column (R runs on a 1 index, just to be confusing)
col.labels <- as.vector(col.levels[,2])

##actually do the grunt work and make you heatmap
##convert the object to a matrix, and transpose it (otherwise your tree will be the wrong way around)
c <- as.matrix(t(b))
#define the number of breaks and color pallete for the heatmap
#I use rcolorbrewer.  pretty colours are only available for values up to 9.
#this line tests that, and if we have any values over 9, it log2 converts the table so we can still use pretty colors.
ifelse(max(c) >8,yes=c <- log2(c+1), no=c <- c)
d <- max(c)
#define the breaks for the heatmap.  this essentially puts each real number in the middle of a break.  Should be modified for log2 converted tables, but I havent done it yet.
e <- seq(-0.5,d+0.5,1)
#Define the colors
y <- brewer.pal(length(e)-1, "Blues")

#PICK THE LINE YOU WANT AND UNCOMMENT IT
#draw the heatmap.  self ordered KO numbers (always my first choice when I have no idea what it will look like)
#x <- heatmap.2(c, Rowv=FALSE, Colv=TRUE, dendrogram='column', scale='none', density='none', breaks=c(e), col=y, trace='none', cexRow=0.6, RowSideColors=rsc, ColSideColors=csc, labCol=col.labels)

#draw the heatmap.  no dendrograms
#x <- heatmap.2(c, Rowv=FALSE, Colv=FALSE, dendrogram='none', scale='none', density='none', breaks=c(e), col=y, trace='none', cexRow=0.6, RowSideColors=rsc, ColSideColors=csc, labCol=col.labels)


#draw the heatmap.  self order on both axis
#x <- heatmap.2(c, Rowv=TRUE, Colv=TRUE, dendrogram='both', scale='none', density='none', breaks=c(e), col=y, trace='none', cexRow=0.6, RowSideColors=rsc, ColSideColors=csc, labCol=col.labels)




#####################
#if you're having trouble following along at home, the following script works beautifully on the files in ./R_test_files

##### General R heatmaps for KO counts tables #########
library("ape")
library("RColorBrewer")
library("gplots")
library("ggplot2")

#in this example, i combined the two photosynthesis categories, and removed the second header line beforehand
a <- read.table("all_photosynthesis_counts.txt", sep="\t", header=T, row.names=1)
a <- a[,1:(dim(a)[2])-1]

a <- rbind(a['K01424',], a['K00926',], a['K01953',], a['K01744',], a['K01674',], a['K01725',], a['K01673',], a['K00285',], a['K01455',], a['K00605',], a['K00262',], a['K01915',], a['K01425',], a['K00264',], a['K00265',], a['K00266',], a['K00284',], a['K00261',], a['K01745',], a['K05601',], a['K01916',], a['K00367',], a['K00370',], a['K00371',], a['K00373',], a['K02585',], a['K02586',], a['K02587',], a['K02588',], a['K02589',], a['K02590',], a['K02591',], a['K02593',], a['K02594',], a['K02595',], a['K02596',], a['K02597',], a['K00366',], a['K00362',], a['K00363',], a['K00372',], a['K01501',], a['K00368',], a['K00459',], a['K04561',], a['K00376',], a['K04015',], a['K14155',], a['K10775',], a['K01668',]) 
b <- cbind(a$A00000079, a$A00001271, a$A00000604, a$A00000579, a$A00000836, a$A00001041, a$C00000092, a$C00000008, a$A00000108, a$A00000527, a$A00000287, a$A00000286, a$A00000291, a$A00000292, a$A00000593, a$A00000299, a$A00000793, a$A00000679, a$A00000294, a$A00001644, a$A00001049, a$A00000923, a$A00000794, a$A00000648, a$A00000792, a$A00001208, a$A00000665, a$A00000186, a$A00001053, a$A00000731, a$A00001188, a$A00000308, a$A00001377, a$A00000197, a$A00000466, a$A00000620, a$A00000199, a$A00000198, a$A00000468, a$A00000573, a$A00000465, a$A00000464, a$A00000196, a$A00000200, a$A00000467, a$A00000289, a$A00000290, a$A00000293, a$A00000288, a$A00000528)

g <- read.tree("cyanowoYS2phylo.tree")
colnames(b) <- g$tip.label
rownames(b) <- rownames(a)


col.levels <- read.table("Photo_KO_gene_category.txt", header=F, sep="\t")
col.levels.list <- as.vector(col.levels[,3])

z <- brewer.pal(3, "Purples")
csc <- c(z)[col.levels.list+1]


row.levels <- read.table("cyano_tree_categories", header=F, sep="\t")
row.levels.list <- as.vector(row.levels[,1])
rsc <- c(Chloroflexi="#EDF8E9", '4C0d-2'="#C7E9C0", Gloeobacterales="#A1D99B", Synechococcales="#74C476", Chroococcales="#41AB5D", Nostocales="#238B45", Oscillatoriales="#005A32")[row.levels.list]

col.labels <- as.vector(col.levels[,2])

c <- as.matrix(t(b))
ifelse(max(c) >8,yes=c <- log2(c+1), no=c <- c)
d <- max(c)
e <- seq(-0.5,d+0.5,1)
y <- brewer.pal(length(e)-1, "Blues")


#draw the heatmap.  self ordered KO numbers (always my first choice when I have no idea what it will look like)
#x <- heatmap.2(c, Rowv=FALSE, Colv=TRUE, dendrogram='column', scale='none', density='none', breaks=c(e), col=y, trace='none', cexRow=0.6, RowSideColors=rsc, ColSideColors=csc, labCol=col.labels)

#draw the heatmap.  no dendrograms
#x <- heatmap.2(c, Rowv=FALSE, Colv=FALSE, dendrogram='none', scale='none', density='none', breaks=c(e), col=y, trace='none', cexRow=0.6, RowSideColors=rsc, ColSideColors=csc, labCol=col.labels)


#draw the heatmap.  no dendrograms
#x <- heatmap.2(c, Rowv=TRUE, Colv=TRUE, dendrogram='both', scale='none', density='none', breaks=c(e), col=y, trace='none', cexRow=0.6, RowSideColors=rsc, ColSideColors=csc, labCol=col.labels)






