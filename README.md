# DynamicProgrammingComposer
### An idea: use dynamic programming to compose  

#### Find out someone has a Markov Composer:   
http://zx.rs/3/Markov-Composer---Using-machine-learning-and-a-Markov-chain-to-compose-music/  

These two approaches have the same drawback: randomly or semi-randomly add a note based on previous (1 or 2) note(s)  

However in real music I believe every new note should be based on several previous notes. There should be a trend(like a music wave or stream) in the whole music. Need further consideration. And music should have repetition, loop, and concentration(基调).  

#### 2015.07.05 update: find another approach: RNNs+LTSMs  
http://www.wise.io/tech/asking-rnn-and-ltsm-what-would-mozart-write

## Current Problem:
notes no repetition.  
Unarycost difficult to design because no composing experience.

## Idea: Aoto rythm generator  
Like the heavy metal washing machine: https://www.youtube.com/watch?v=7pirhdH8DTM

reference:  
http://nlolab.swarthmore.edu/webstuff/phys22/matlabwkshpii/matlabwkshpii.pdf  
http://uk.mathworks.com/moler/exm/chapters/music.pdf  
http://www.bilibili.com/video/av1768861/ (编曲)  
