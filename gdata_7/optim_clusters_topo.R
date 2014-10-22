# UNFINISHED. 
## Include gap statistic -- DONE
## Return optimal number of clusters according to the gap
## cluster data using pam with optimal k. Save a table with the cluster info and the clustering assignement
## Include option to plot restults

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
      cat('bootstrap replicate' , i, 'the average silhouete width is', mean(boot_dat_clus[[i]]), '\n')

  }
  stopCluster(cl)


  gap_stats <- list()
  for(i in 1:length(boot_dat_clus)){
    gap_stats[[i]] <- as.numeric(true_dat_clus) - as.numeric(boot_dat_clus[[i]])
  }


  rec_rbind <- function(list_data){
    if(length(list_data) == 1) stop('The list has length = 1. Nothing to concatenate')
    if(length(list_data) == 2){
      return(rbind(list_data[[1]], list_data[[2]]))
    }else{
      return(rbind(list_data[[1]], rec_rbind(list_data[-1])))
    }
  }


  gap_stats <- rec_rbind(gap_stats)



  return(list(as.numeric(true_dat_clus), boot_dat_clus, mds_dat, gap_stats))

}

test_1 <- optim_clusters_topo('topo_dist_mat.txt', n_clusters = 5, kmax = 50, b_reps = 100)


#plot(2:(length(gap_stats[[1]]) + 1), gap_stats[[1]], ylim = c(0, 0.8))
#for(i in 2:length(gap_stats)){
#      points(jitter(2:(length(gap_stats[[1]]) + 1)), gap_stats[[i]])
#}




