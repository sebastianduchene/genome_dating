library(cluster)

dist_mat <- as.matrix(read.table('topo_dist_mat.txt', head = T, as.is = T))

dist_mat[upper.tri(dist_mat, diag = T)] <- 0

num_mat  <- matrix(as.numeric(dist_mat), ncol = ncol(dist_mat), nrow = nrow(dist_mat), dimnames = list(colnames(dist_mat), rownames(dist_mat)))

mds_mat <- cmdscale(as.dist(num_mat), k = 2)

clu5 <- pam(mds_mat, k = 5)

plot(mds_mat, pch = 20, cex = 2, col = clu5$clusteri)

medoid_data <- rownames(clu5$medoids)

# Dists from medoid to true gts:


all_trees <- read.tree('nj_trees.trees')
true_trees <- read.tree('simtree1.tre')

# Just because they are in order

medoid_trees <- all_trees[names(all_trees) %in% medoid_data]

dist_trees <- vector()

for(i in 1:length(medoid_trees)){
      dist_trees[i] <- dist.topo(medoid_trees[[i]], true_trees[[i]])

}


# !!! In this case the medoid corresponds to the true tree Otherwise concatenate....

# concatenate all genes according to their clustering

gt_clusters <- cbind(names(clu5$clustering), clu5$clustering)


#for(i in unique(gt_clusters[, 2])){
#      data_sets <- gt_clusters[gt_clusters[, 2] == i, 1]
#      concat_dat <- read.dna(data_sets[1], format = 'fasta')
#      for(k in 2:length(data_sets)){
#      	    concat_dat <- cbind(concat_dat, read.dna(data_sets[k], format = 'fasta'))
#      }
#      write.dna(concat_dat, file = paste0('concat_data_', i, '.fasta'), format = 'fasta', nbcol = -1, colsep = '')
#}


concat_data_1 <- read.dna('concat_data_1.fasta', format = 'fasta')
gt_1 <- nj(dist.dna(concat_data_1))

concat_data_2 <- read.dna('concat_data_2.fasta', format = 'fasta')
gt_2 <- nj(dist.dna(concat_data_2))

concat_data_3 <- read.dna('concat_data_3.fasta', format = 'fasta')
gt_3 <- nj(dist.dna(concat_data_3))

concat_data_4 <- read.dna('concat_data_4.fasta', format = 'fasta')
gt_4 <- nj(dist.dna(concat_data_4))

concat_data_5 <- read.dna('concat_data_5.fasta', format = 'fasta')
gt_5 <- nj(dist.dna(concat_data_5))

# It works!! The concatenated trees match the true gene trees!


dist.topo(true_trees[[1]], gt_1)
dist.topo(true_trees[[2]], gt_2)
dist.topo(true_trees[[3]], gt_3)
dist.topo(true_trees[[4]], gt_4)
dist.topo(true_trees[[5]], gt_5)
