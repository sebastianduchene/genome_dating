
for(i in dir('../functions', pattern = 'R$')){
      source(paste0('../functions/', i))
}

#top_dists <- get_topo_dist(tree_file_name = 'nj_trees.trees')

#top_clusts <- optim_clusters_topo('out_topo_dist.txt', kmax = 20, plot_clustering = T)

# Select two clusters; largest and narrowest

dat_gt1 <- names(top_clusts$cluster_id)[top_clusts$cluster_id == 1]
dat_gt5 <- names(top_clusts$cluster_id)[top_clusts$cluster_id == 5]



rec_cbind <- function(list_mat){
	if(length(list_mat) == 2){
	  return(cbind(list_mat[[1]], list_mat[[2]]))
	}else{
	  return(cbind(list_mat[[1]], rec_cbind(list_mat[-1])))
	}
}

# THIS IS TO GET THE CONCATENATED TREES FOR THE CLUSTERS SELECTED. NEXT OPTIMISE THE BRANCH LENGTHS OVER THE INDIVIDUAL GENES.
dat_gt1_clus <- list()

for(i in 1:length(dat_gt1)){
      dat_gt1_clus[[i]] <- read.dna(dat_gt1[i], format = 'fasta')
}

dat_gt1_concat <- rec_cbind(dat_gt1_clus)
tr_gt1_concat <- nj(dist.dna(dat_gt1_concat))
write.tree(tr_gt1_concat, file = 'tr_gt1_concat.tree')


dat_gt5_clus <- list()

for(i in 1:length(dat_gt5)){
      dat_gt5_clus[[i]] <- read.dna(dat_gt5[i], format = 'fasta')

}

dat_gt5_concat <- rec_cbind(dat_gt5_clus)
tr_gt5_concat <- nj(dist.dna(dat_gt5_concat))
write.tree(tr_gt5_concat, file = 'tr_gt5_concat.tree')