library(cluster)

dist_mat <- as.matrix(read.table('topo_dist_mat.txt', head = T, as.is = T))

dist_mat[upper.tri(dist_mat, diag = T)] <- 0

num_mat  <- matrix(as.numeric(dist_mat), ncol = ncol(dist_mat), nrow = nrow(dist_mat), dimnames = list(colnames(dist_mat), rownames(dist_mat)))

mds_mat <- cmdscale(num_mat, k = 2)


clu5 <- pam(mds_mat, k = 5)


plot(mds_mat, pch = 20, cex = 2, col = clu5$clusteri)

medoid_data <- rownames(clu5$medoids)



