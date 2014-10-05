# Data simulation for genome dating

Updated on: Oct 5 2014

Sebastian Duchene


## Simulate data with 5 topologies (gt) and 3 pacemakers (pm) for each topology

In this simulation the number of genes is 510. Bootstrapping to find the optimal number of clusters from 2:50 is taking 24 seconds with 5 cores.

   - Can we recover the true number of gt clusters?

   Silhouette width plot
   ![fig1](https://raw.githubusercontent.com/sebastianduchene/genome_dating/master/gdata_1/silhouette_plot.png)

   **Fig 1. Average silhouette width for numbers of gt clusters**


   ![fig2](https://raw.githubusercontent.com/sebastianduchene/genome_dating/master/gdata_1/topology_clusters.png)

   **Fig 2. MDS of gt clusters**

   ** To do** 

   Does the medoid correspond to the true tree? What about the concatenated data?
   
   Plot trees and tree distances
