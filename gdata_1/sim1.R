require(geiger)
require(phangorn)

getPairdist <- function(trs){
	    mat <- matrix(0, nrow = length(trs), ncol = length(trs))
	    for(i in 1:length(trs)){
	    	  for(j in i:length(trs)){
		  
			mat[i, j] <- dist.topo(trs[[i]], trs[[j]])
		  
		  }
	    }
	    return(mat)
}


getTrs <- function(n = 5, moves = 5, taxa = 20){

## Simulate tree topologies using NNI.

tr <- sim.bdtree(1, 0, stop = "taxa", n = taxa)
#tr <- rtree(20)
trs <- list()
trs[[1]] <- tr

for(i in 2:(n*20)){
      trs[[i]] <- try(rNNI(tr, moves = moves, n = 1))
      while(class(trs[[i]]) == "try-error") trs[[i]] <- try(rNNI(tr, moves = moves, n = 1))
      print(dist.topo(tr, trs[[i]]))
}

return(trs)

}

getCongtrs <- function(trs, cladea, cladeb){

	   trees <- list()
	   for(i in 1:length(trs)){
	   	 if(is.monophyletic(trs[[i]], cladea) & is.monophyletic(trs[[i]], cladeb)){
		 	trees[[length(trees) + 1]] <- trs[[i]]
		 }
	   }

	   res <- list(tr = trees, pairdist = getPairdist(trees))

	   return(res)

}

# congs <- getCongtrs(trisitos, c("s8", "s9","s10","s11","s12"), c("s3","s4","s5","s6","s7"))