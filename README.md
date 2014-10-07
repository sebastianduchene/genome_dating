# Data simulation for genome dating

Updated on: Oct 5 2014

Sebastian Duchene


## Simulate data with 5 topologies (gt) and 3 pacemakers (pm) for each topology

In this simulation the number of genes is 510. Bootstrapping to find the optimal number of clusters from 2:50 is taking 24 seconds with 5 cores.

   - Can we recover the true number of gt clusters?

   Silhouette width plot
   ![fig1](https://raw.githubusercontent.com/sebastianduchene/genome_dating/master/gdata_1/silhouette_plot.png)

   **Fig 1. Average silhouette width for numbers of gt clusters**

 According to the silhouette with, the number of gts is 5, corresponding to the number of gts used to generate the data.

   ![fig2](https://raw.githubusercontent.com/sebastianduchene/genome_dating/master/gdata_1/topology_clusters.png)

The clustering algorithm classifies the trees correctly. (this is in the mds_clustering script). 

   **Fig 2. MDS of gt clusters**

The distance between the mediods and the true gts is:

- gt1 vs. tr_1_pm_1_20.fasta = 0

- gt2 vs. tr_2_pm_3_20.fasta = 0

- gt3 vs. tr_3_pm_1_20.fasta = 6

- gt4 vs. tr_4_pm_3_20.fasta = 0

- gt5 vs. tr_5_pm_3_20.fasta = 0

The true gt is contained in the gt clusters for all of the clusters. This will not always be the case. 

The clusters are defined as follows:

```   
      size max_diss   av_diss diameter separation
 [1,]  120 3.901706 1.4369595 7.531254   5.258430
 [2,]  100 5.370699 2.0334611 8.372119   2.381935
 [3,]  100 5.345461 1.6231791 9.387836   2.381935
 [4,]  100 2.490626 0.8647195 4.687670   5.876823
 [5,]   90 2.536509 0.5860012 4.774257   7.484193
```

The largest cluster is #1, with 120 genes, but it is also the second widest. This implies that there is considerable variation in the gts for this cluster. The narrowest cluster is #5, but it is also the smallers, with 90 genes. Two reasonable strategies for genome dating are:

 - Use the largest cluster to maximise the amount of sequece data

 - Use the narrowest cluster, which is equivalent to selecting the most congurent set of genes. 

   ![fig3](https://raw.githubusercontent.com/sebastianduchene/genome_dating/master/gdata_1/trees_exmamples.png)

   **Fig3. Example of simulated gts and medoid gts. Row 1 is cluster 1, and Row 2 is for cluster 2. Column 1 is for the simulated (true) gts and column 2 is the medoid estimated with nj.**


   - We can recover the true trees by concatenating the cluster data, or by using the medoid. However concatenating is more reliable. 

   **To do**
   
   - Select candidate clusters for genome dating
   
   - Run clockstar for simulated data on the largest cluster and hte narowest    
   Plot trees and tree distances
