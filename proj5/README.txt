Vyas K. Srinivasan
vsrinivasan40
Project 5

I think most of the substantive project-related discussion has been largely discussed
in my HTML writeup. Having said that, there are some additional points I'd like to
make related to how to run my code/acknowledgements I'd like to give.

In terms of code-related comments:

0. First an foremost. My Linear SVM Lambda is always 0.0001. Additionally,
my Linear SVM Score threshold is always 0 unless I specify otherwise. The only 
cases where it is not are:
	
	a. When I run my own hog implementation (I used -0.5 to get my results)
	b. When I got the results for the class picture. I used a threshold of 0.7 
	to get cleaner looking results. 

1. Out of the box, my code is set up to run the baseline pipeline (using linear SVM) 
with a HoG cell size of 6. If you run it as is, the results should match up fairly
closely with the results shown in my 'Baseline Implementation' HTML writeup 
section. I say 'fairly closely' because I randomly sample negative each time the 
code runs. Thus, across runs there is no guarantee that the results will be the exact 
same, but they should match up quite closely. To run the baseline pipeline with 
different cell sizes (e.x. 4 or 3), you simply need to change the hog cell size 
argument of the feature_params constructor at line 56. Note that running this
baseline pipeline at any of these 3 cell sizes should run well within the 10 minute
suggested time constraint (I've reported the run-time of these 3 runs on my writeup. 
The slowest of the 3 (cell size = 3) ran in ~8 minutes on my computer).

2. In order to replicate the bells and whistles results related to my HoG implementation
you'll need to manually comment out/in some lines of code. I apologize up front 
that you need to do this, but rest assured it's fairly easy to do:
	
	a. Open get_positive_features(). Comment out line 40. Comment in line 41. Comment
	out lines 48 and 49. Comment in line 50.
	
	b. Open get_random_negative_features(). Comment out line 85. Comment in line 86.
	
	c. Open run_detector(). Change 'threshold' in line 51 to -0.5 (should currently
	be 0). Comment out line 86. Comment in line 87. 

	d. Comment out 'step 3' of proj5.m entirely (lines 115-148). This section produces
	a visualization of the learned classifier, but the dimensions are hardcoded for
	the VL_Feat output. So we just comment it out since we don't need it.
	
I should warn you up front - my HoG implementation (my_hog().m) is slow compared
to the VLFeat's implementation. To replicate the results I show in my Bells & Whistles
section, the code will likely need to run for ~40 minutes. 

3. Replicating the results of my bells & whistles work related to multiple classifiers
is much easier to do:
	
	a. Ensure that whatever changes (comments in/out) that have been done to facilitate
	running my HoG implementation have been undone (i.e. you want it to be in the state 
	it was out of the box).
	
	b. Edit the 'linear_svm', 'neural_net', and 'nearest_neighbor' flags at lines
	59-61 of proj5.m to indicate which classifier you want to run. To run the 
	ensemble voting classifier, just make each one equal to 1. Note that my code
	only currently supports one of them, or all of them. It won't run correctly if you 
	make two of them equal to 1 and a third equal to 0. It's mentioned on my writeup
	but I'll mention it here again - The results shown in this section of my report 
	are gotten with a HoG cell size of 6. 
	
A few final comments on this multiple classifiers issue with regards to run time. 
The process of training my neural network is somewhat slow. Thus, I've saved a 
set of weights in my code folder that gets loaded if available ('nn_weights_2000_cs6.mat').
If you want the code to actually run through the feed-forward/backpropogation cycle, just 
delete this .mat file and run the code. Be warned though, it takes some time. Additionally,
be warned that running my nearest neighbor classifier or my ensemble classifier is also
very slow (even with approximate nearest neighbor, it still takes a while). If you are
trying to run either of these two classifiers (nearest neighbor/ensemble), it will likely takes
around an hour to complete. 

4. Finally, I'd like to point out that while the precision-recall graphs I show
in my writeup were made in excel (I wanted to be able to show multiple curves on 
one plot), I have saved the original curves output by the code in my HTML folder under
the appropriately labeled subfolders. Also in my HTML folder, you can find my Viola-Jones 
plot comparison when I used my best implementation (baseline pipline with cell size = 3). It 
is located under the subfolder 'Viola_Jones_Comparison'.

In terms of acknowledgement-related comments:

1. I'd like to give credit to the following sorce for guiding me step-by-step through
how to write my own neural network code:http://code-spot.co.za/2009/10/08/15-steps-to-implemented-a-neural-net/

Note - The source simply describes what functions you will need and what each 
function should implement during its running. I wrote each of the functions myself. 

2. Addtionally with regard to neural nets, I'd like to give credit to this source: 
http://stevenmiller888.github.io/mind-how-to-build-a-neural-network/

While the previous source taught me how to build one, this source gave me some intuition for
what I was doing.

3. I'd like to give credit to VL_Feat for their kd-tree and approximate nearest neighbor 
implementation. I made use of their implementation in my code when I was trying to 
get a computationally-feasible nearest neighbor classifier. 