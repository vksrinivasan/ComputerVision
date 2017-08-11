Vyas K. Srinivasan
vsrinivasan40
Project 4

Most of the content-related points I wanted to make about the project can be found
in my HTML writeup. There are, however, a few points related to my code and references
that I'd like to mention here.

Points Related to Code:

- Out of the box, this code will run Bag of SIFT features with Linear SVM classifier
at a vocabulary size of 200. This meets the specification in your 'Guidelines 
for Project 4' piazza post related to 'Bag of SIFT representation and linear SVM
classifier (min accuracy 55%)'. Additionally, the output of the code should closely
match the results on my writeup in the 'Bag of Words Feature Representation (SIFT) 
with Linear SVM Classifier' section. I say closely because I use a fairly low 
lambda that results in a non-deterministic SVM. Just from my testing, the 
results should be within a percent or so.

- If you change the out of the box code at lines 19 and 20 (to switch FEATURE 
from 'bag of sift' to 'tiny image' and to switch CLASSIFIER to 'nearest neighbor'), 
you can get the results for the additional two runs you requested: 
'Tiny images representation and nearest neighbor classifier (min accuracy 15%)' 
and 'Bag of SIFT representation and nearest neighbor classifier (min accuracy 45%)'. 
These will correspond to my results in my HTML writeup sections:
'Tiny Image Features with Nearest Neighbor Classifier' and 
'Bag of Words Feature Representation (SIFT) with Nearest Neighbor Classifier'. 

- To reproduce the results from my Bells & Whistles section, you will need to 
switch lines 19 and 20 back to FEATURE = 'bag of sift' and CLASSIFIER = 
'support vector machine'. Additionally, you will need to switch line 85 from 
vocab_size = 200 to vocab_size = 600. Note - In my /code/ folder, I have included
a vocab_600.mat file which corresponds to the 600 visual word vocabulary (the 
vocab.mat that already exists corresponds to the 200 vocab size). Feel
free to just switch the name of this file to vocab.mat so that you don't need to 
re-run the vocabulary generation process. 

- In terms of how to add on each Bells & Whistles item, you will need to change
lines 71-73 (Spatial_Pyramid, GIST, kernel_codebook_encoding). These are 
integer flags that are set to 0 out of the box. You can change each one/all of them 
to '1' to 'turn them on'. 

- Unfortunately, I did not create a similar flag for the RBF kernel. To use the 
RBF kernel, you will need to go into svm_classify.m and comment out lines 68, 
73, 74, 90, 91, and comment in lines 76, 77, 93, 94. I apologize for making
the extra work, but it should be easy enough to do. 

References/Credit I want to give: 

- I want to give credit to Aude Oliva, and Antonio Torralba's LMgist matlab 
function that I made use of

- For Kernel Codebook Encoding, the idea to use the weighting scheme from Philbin
et al was not my own. I was googling around 'Soft Assignment Bag of Words' and I came
across this person's project page: http://cs.brown.edu/courses/cs143/2011/results/proj3/psastras/
He/she mentioned this weighting scheme in their writeup and it seemed interesting 
enough to try, so I looked at the paper and wrote my own code to do it. I just want
to give credit to them for the idea. 

- For the RBF kernel, I want to give credit to 2 sources. First, I want to give 
credit to Olivier Chappelle for his primal_svm matlab code (http://olivier.chapelle.cc/primal/). 
Additionally, I want to give credit to Tijl De Bie (http://www.kernel-methods.net/matlab/kernels/rbf.m) 
for his code to compute the RBF kernel. I saw the mathematical formulation of the 
kernel online, and his code helped me understand what exactly it meant. 

- For the Spatial Pyramid, I want to give credit to this source: 
http://www.andrew.cmu.edu/user//jianwan2/Task1/hw2.pdf. The source is essentially
a HW assignment description for a CMU course, and it in detail goes over the 
weighting scheme for the Spatial Pyramid histograms. While I understood the idea
of subdividing the image and calculating/appending more histograms, I didn't quite
understand what Lazebnik meant by giving them different weighting. This HW assignment
description helped me fill in that gap in my knowledge. 