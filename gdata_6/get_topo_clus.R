
for(i in dir('../functions/', pattern = 'R$')){
  source(paste0('../functions/', i))
}

opt_topo <- optim_clusters_topo('topo_dist_mat.txt', plot_clustering = T)