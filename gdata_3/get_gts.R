library(ClockstaR2)
library(ape)

topo_dists <- as.matrix(read.table('topo_dist_mat.txt', head = T, as.is = T))
topo_dists[upper.tri(topo_dists, diag = T)] <- 0
topo_dists[1:nrow(topo_dists), 1:ncol(topo_dists)] <- as.numeric(topo_dists[1:nrow(topo_dists), 1:ncol(topo_dists)])
num_dists <- matrix(as.numeric(topo_dists), nrow = nrow(topo_dists), ncol = ncol(topo_dists))

num_dists <- as.dist(num_dists)

cluster_id <- read.table('clust_k_5.txt', as.is = T, head = T)


# There are two options: select the largest topology cluster (1), or that with the lowest average dissimilarity (5)


# Get gt topologies by concatenating.

clust_1_data <- rownames(cluster_id)[cluster_id == 1]
clust_1_concat <- read.dna(clust_1_data[1], format = 'fasta')
for(i in 2:length(clust_1_data)){
 clust_1_concat <- cbind(clust_1_concat, read.dna(clust_1_data[i], format = 'fasta'))
}

clust_1_gt <- nj(dist.dna(clust_1_concat))
write.tree(clust_1_gt, file = 'cluster_1_gt.tree')


clust_5_data <- rownames(cluster_id)[cluster_id == 5]
clust_5_concat <- read.dna(clust_5_data[1], format = 'fasta')
for(i in 2:length(clust_5_data)){
 clust_5_concat <- cbind(clust_5_concat, read.dna(clust_5_data[i], format = 'fasta'))
}

clust_5_gt <- nj(dist.dna(clust_5_concat))
write.tree(clust_5_gt, file = 'cluster_5_gt.tree')
