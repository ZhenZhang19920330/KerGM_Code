1. We add our algorithm KerGM to the platform originally developed by Dr. Feng Zhou  
   (http://www.f-zhou.com/index.html), and Prof. Tao Wang (http://faculty.bjtu.edu.cn/7630/).
   We thank Feng and Tao for releasing their codes.
  
   Note that the platform is download from the following website:
   http://www.dabi.temple.edu/~hbling/code/BPF/bpf-2017.htm

2. By running the code, the users may get the matching results on CMU-House and Pascal dataset,  
   as shown in the Fig.6 and Fig. 7 in the following paper. 
   "KerGM: Kernelized Graph Matching", Zhen Zhang, Yijian Xiang, Lingfei Wu, Bing Xue, Arye Nehorai
   (1). Run the file "make1.m"
   (optional). If the compiling process cannot be successfully executed, run the file "make2.m"
   (2). Run the file "addPath.m"
   (3). Run the file "Main_HouseDataset.m"
        Run the file "Resultplot_ACC_Ratio_House.m"
        You may get the results shown in Fig.6.
   (4). Run the file "Main_PascalDataset.m"
        Run the file "Resultplot_ACC_Time_Pascal.m"
        You may get the results shown in Fig.7.
   (5). Run the file "DrawPascalMatchingResult.m", you may get the visualization of an example of 
        Pascal dataset.
        
    

3. For these two image datasets, we use the exact edge affinity kernels for KerGM.
   
