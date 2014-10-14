
          seed = -1
       seqfile = concat_clocks.phy
      treefile = concat_tree.phy
       outfile = out_scaling_1

         ndata = 3
       seqtype = 0    * 0: nucleotides; 1:codons; 2:AAs
       usedata = 0    * 0: no data; 1:seq like; 2:normal approximation; 3:out.BV (in.BV)
         clock = 2    * 1: global clock; 2: independent rates; 3: correlated rates
       RootAge = '>99<101'  * safe constraint on root age, used if no fossil for root.

         model = 4    * 0:JC69, 1:K80, 2:F81, 3:F84, 4:HKY85
         alpha = 0.5    * alpha for gamma rates at sites
         ncatG = 5    * No. categories in discrete gamma

     cleandata = 0    * remove sites with ambiguity data (1:yes, 0:no)?

       BDparas = .01 .01 0.01 * birth, death, sampling
   kappa_gamma = 6 2      * gamma prior for kappa
   alpha_gamma = 1 1      * gamma prior for alpha

   rgene_gamma = 2 2000    * gammaDir prior for rate for genes
  sigma2_gamma = 1 10   * gammaDir prior for sigma^2     (for clock=2 or 3)

      finetune = 1: .1 .1 .1 .1 .1 .1 * auto (0 or 1): times, rates, mixing, paras, RateParas, FossilErr

         print = 1
        burnin = 2000
      sampfreq = 2
       nsample = 20000

*** Note: Make your window wider (100 columns) before running the program.
