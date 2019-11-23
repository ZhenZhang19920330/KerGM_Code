1. We add our algorithm KerGM to the platform originally developed by Dr. Feng Zhou  
   http://www.f-zhou.com/index.html. We thank Feng for releasing his code.

2. By running the code, the users may get the matching results on synthetic graphs,  
   as shown in the Fig.3 in the following paper. 
   "KerGM: Kernelized Graph Matching", Zhen Zhang, Yijian Xiang, Lingfei Wu, Bing Xue, Arye Nehorai
   
   (1). Run the file "make1.m"
   (optional). If the compiling process cannot be successfully executed, run the file "make2.m"
   (2). Run the file "addPath.m"
   (3). Run the file "Main_RandomGraph.m", and set the "setting=1, 2, and 3". 
        In this file, we compare different state-of-the-art Graph Matching algorihtms, including:
        IPFP, SMAC, PM, RRWM, FGM, KerGM 
   (4). Run the file "Accuracy_ResultsPlot", you may get the results shown in Fig.2(a). 
   (5). Run the file "Main_TimeComparing.m", you may get the running cpu time for the above graph 
        matching aglorithms.
        Warning: If you set the number of nodes "inlier > 200", we strongly suggest you test only the
                 KerGM algorithm, and comment the remaining algorithms.
3. For this synthetic dataset, we use the random Fourier features, whose inner product can approximate
   the Gaussian kernel.
 