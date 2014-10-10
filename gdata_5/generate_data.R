# Data simulation for genome dating

## Tree topology 

### use 

library(phangorn)

trees_topo <- read.tree('simtree1.tre')

for(i in 1:length(trees_topo)){
  trees_topo[[i]] <- chronopl(trees_topo[[i]], lambda = 5, age.min = 100)
  print(max(branching.times(trees_topo[[i]])))

}

write.tree(trees_topo, file = 'sim_chrono.tre')

set.seed(123456)
pm1 <- rlnorm(38, -6.9, 0.2)


var_sites_mat <- matrix(NA, 500, 2)
var_temp <- 0

#tree 1. Large wide cluster with low rates
      tree_temp <- trees_topo[[1]]
      tree_temp$edge.length <- tree_temp$edge.length * pm1 / 3
      for(k in 1:150){
      	    sim_temp_1 <- as.DNAbin(simSeq(tree_temp, l = 1000))
	    write.dna(sim_temp_1, file = paste0('tr_1_', k, '.fasta'), format = 'fasta', nbcol = -1, colsep = '')
	    
	    var_temp <- var_temp + 1
	    var_sites_mat[var_temp, ] <- c(paste0('tr_1_', k, '.fasta'), length(seg.sites(sim_temp_1)))

      }

#tree 2. Large wide cluster with low rates
      tree_temp <- trees_topo[[2]]
      tree_temp$edge.length <- tree_temp$edge.length * pm1 / 3
      for(k in 1:100){
      	    sim_temp_1 <- as.DNAbin(simSeq(tree_temp, l = 1000))
	    write.dna(sim_temp_1, file = paste0('tr_2_', k, '.fasta'), format = 'fasta', nbcol = -1, colsep = '')
	    
	    var_temp <- var_temp + 1
	    var_sites_mat[var_temp, ] <- c(paste0('tr_2_', k, '.fasta'), length(seg.sites(sim_temp_1)))

      }

#tree 3. Large wide cluster with low rates
      tree_temp <- trees_topo[[3]]
      tree_temp$edge.length <- tree_temp$edge.length * pm1 / 3
      for(k in 1:100){
      	    sim_temp_1 <- as.DNAbin(simSeq(tree_temp, l = 1000))
	    write.dna(sim_temp_1, file = paste0('tr_3_', k, '.fasta'), format = 'fasta', nbcol = -1, colsep = '')
	    
	    var_temp <- var_temp + 1
	    var_sites_mat[var_temp, ] <- c(paste0('tr_3_', k, '.fasta'), length(seg.sites(sim_temp_1)))

      }

#tree 4. Large wide cluster with low rates
      tree_temp <- trees_topo[[4]]
      tree_temp$edge.length <- tree_temp$edge.length * pm1 / 3
      for(k in 1:100){
      	    sim_temp_1 <- as.DNAbin(simSeq(tree_temp, l = 1000))
	    write.dna(sim_temp_1, file = paste0('tr_4_', k, '.fasta'), format = 'fasta', nbcol = -1, colsep = '')
	    
	    var_temp <- var_temp + 1
	    var_sites_mat[var_temp, ] <- c(paste0('tr_4_', k, '.fasta'), length(seg.sites(sim_temp_1)))

      }

#tree 5. Large wide cluster with low rates
      tree_temp <- trees_topo[[5]]
      tree_temp$edge.length <- tree_temp$edge.length * pm1
      for(k in 1:50){
      	    sim_temp_1 <- as.DNAbin(simSeq(tree_temp, l = 1000))
	    write.dna(sim_temp_1, file = paste0('tr_5_', k, '.fasta'), format = 'fasta', nbcol = -1, colsep = '')
	    
	    var_temp <- var_temp + 1
	    var_sites_mat[var_temp, ] <- c(paste0('tr_5_', k, '.fasta'), length(seg.sites(sim_temp_1)))

      }


write.table(var_sites_mat, file = 'var_stes.txt', row.names = F)

