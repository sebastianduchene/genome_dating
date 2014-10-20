library(ape)

chrono_trees <- read.tree('sim_chrono.tre')

ages <- sapply(1:5, function(x) branching.times(chrono_trees[[x]]))

