# UNFINISHED. 
## INCLUDE PRINTING AND RETURN DATA WITH COHERENT NAMES. 
## INCLUDE OPTION TO PRINT RESULTS
## INCLUDE OPTIMAL NUMBER OF CLUSTERS SELECTING WITH GAP 

optim_clusters_topo <- function(topo_mat_file, out_mds_file = 'mds_topo.txt', n_clusters = 2, kmax , b_reps = 100, out_clustering = 'opt_clus.txt', out_clusinfo = 'opt_clusinfo.txt'){

  require(cluster)
  require(ape)
  require(doParallel)

  dat_raw <- as.matrix(read.table(topo_mat_file, head = T, as.is = T))
  dat_raw[upper.tri(dat_raw, diag = T)] <- 0
  dat_raw[1:ncol(dat_raw), 1:nrow(dat_raw)] <- as.numeric(dat_raw)

  dat_dist <- as.dist(dat_raw)
  mds_dat <- cmdscale(dat_dist, k = 2)
  write.table(mds_dat, file = out_mds_file, row.names = T)

  ### functions

  clus_fun <- function(x, kmax) sapply(2:(kmax), function(i) clara(x, k = i)$silinfo$avg.width )
  clus_fun_par <- function(x, kmax) foreach(i = 2:(kmax), .combine = cbind) %dopar% cluster::clara(x, k = i)$silinfo$avg.width

  get_boot_rep <- function(x){
    boot_mat <- cbind(runif(nrow(x), min(x[, 1]), max(x[, 1])), runif(nrow(x), min(x[, 2]), max(x[, 2])))
  }

  if(missing(kmax)){
    kmax = round(nrow(mds_dat) / 2, 0)
  }


  cl <- makeCluster(n_clusters)
  registerDoParallel(cl)
  true_dat_clus <- clus_fun_par(mds_dat, kmax)
  stopCluster(cl)

  boot_dat_clus <- list()

  cl <- makeCluster(n_clusters)
  registerDoParallel(cl)
  for(i in 1:b_reps){
      boot_dat_temp <- get_boot_rep(mds_dat)
      boot_dat_clus[[i]] <- clus_fun_par(boot_dat_temp, kmax)
      cat('bootstrap replicate' , i, 'silhouete width is', mean(boot_dat_clus[[i]]), '\n')

  }
  stopCluster(cl)

#pdf('topo_clusters.pdf')
#par(mfrow = c(2, 1))
#plot(2:50, as.numeric(true_dat_clus), type = 'l', lwd = 2, col = 'red', ylim = c(0.3, 1), ylab = 'Average silhouette width', xlab = 'Number of topology clusters')
#for(i in 1:length(boot_dat_clus)){
#      points(jitter(2:50), as.numeric(boot_dat_clus[[i]]), pch = 20, col = rgb(0, 0, 0.5, 0.2))

#}

#clu1 <- pam(mds_dat, k = 5)

#plot(mds_dat, pch = 20, col = clu1$clustering, xlab = 'MDS 1', ylab = 'MDS 2')

#dev.off()

  #write.table(t(t(clu1$clustering)), file = out_clustering, row.names = T)
  #write.table(clu1$clusinfo, file = out_clusinfo, row.names = F)

  return(list(as.numeric(true_dat_clus), boot_dat_clus, mds_dat))

}

#to test:
test_1 <- optim_clusters_topo('out_test_1.txt', n_clusters = 5
, b_reps = 50, kmax = 98)

plot(2:98, test_1[[1]], type = 'l', ylim = c(0.2, 0.7))
for(i in 1:length(test_1[[2]])){
  points(2:98, test_1[[2]][[i]], col = rgb(0, 0, 0.5, 0.3))
}

