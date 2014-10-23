library(ape)

tr1 <- rtree(20)

pm1 <- rlnorm(38, -4.6, 0.3)
pm2 <- rlnorm(38, -4.6, 0.3)
pm3 <- rlnorm(38, -4.6, 0.3)



trs <- list()

for(i in 1:10){

      trs[[i]] <- tr1
      trs[[i]]$edge.length <- pm1 + rnorm(38, 0.001, 0.001)
      plot(trs[[i]])
}

for(i in 11:20){
      trs[[i]] <- tr1
      trs[[i]]$edge.length <- pm2 + rnorm(38, 0.001, 0.001)
      plot(trs[[i]])
}

for(i in 21:30){
      trs[[i]] <- tr1
      trs[[i]]$edge.length <- pm3 + rnorm(38, 0.001, 0.001)
      plot(trs[[i]])
}

class(trs) <- 'multiPhylo'
names(trs) <- paste0('A_', 1:30)

write.tree(trs, file = 'test_trees.trees', tree.names = T)