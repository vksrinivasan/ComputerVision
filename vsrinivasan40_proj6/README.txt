Vyas Kattiganehalli Srinivasan
903238872
Project 6

Most of the content-related points I wanted to make I've talked about in my html 
writeup. Here, however, I just wanted to touch on a few points related to how to
run my code. 

The first point I want to make is that my code assumes that MatConvNet is already
working. Both my proj6_part1.m and proj6_part2.m comment out the line that 
calls the MatConvNet setup. Also, my Part 2 code assumes that imagenet-vgg-f.mat
is in the same directory as your current path.

Code Related to Part 1:

- proj6_part1.m
- proj6_part1_cnn_init.m
- proj6_part1_setup_data.m

I've made a few changes to these scripts/functions. In particular, you'll notice
in line 7 of proj6_part1.m that there is now a variable called methodologyNum
that gets passed around to all of the other functions. methodologyNum corresponds
to the methodology step number in my html writeup for 'Strategy 1'. To be more
specific:

- methodologyNum = 1 corresponds to running the code as it would have been out 
of the box (i.e. downloading it from the course website)

- methodlogyNum = 2 corresponds to running the out of the box code + including 
jittering

- methodologyNum = 3 corresponds to running the out of the box code + including
jittering + including zero-mean-ing the images

- methodologyNum = 4 corresponds to running the out of the box code + including
jittering + including zero mean + including dropout layer

- methodologyNum = 5 corresponds to running the out of the box code + including
jittering + including zero mean + including dropout layer + including deeper 
network (i.e. another convolutional and max pool layer)

The code I've submitted has methodologyNum set to be equal to 5 out of the box,
as the instructions mention that this is the deliverable for part 1. However,
since my writeup included the results from the previous steps, I thought it'd 
be helpful to include the ability to run those easily as well.

Code Related to Part 2:

- proj6_part2.m
- proj6_part2_cnn_init.m
- proj6_part2_setup_data.m

This code should run out of the box if you just call run 'proj6_part2'. 

That should be everything you need. Thanks!