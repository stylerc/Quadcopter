Simulink Project: Quadcopter


Before running the Simulink Quadcopter project please run "startup.m"
This will load the necessary values into your workspace for the model to use.
If you would like to change the quadcopter's initial position it is also found
in startup.m.

Next, load systemmain.slx.  This is the overall quadcopter project.
You man run the project at any time. In its default configureation the 
quadcopter will launch from (0,0,0) and hover at 10m. 

Inputs to the controllers can be modified at the far left of the project.
Altitude is in m, roll pitch and yaw are in degrees.  In order to view the 
output of the model open the scope labeled 'position' at the far right of
the project. The output is also saved to the workspace as quad_pos.mat

To run the visualizer simply type Quad_Vis into matlab. To change the view
of the visualizer simply open Quad_Vis.m and modify lines 159 and 160. To 
record the video uncomment line 170. The video will be saved as 
'QC_Visual' in the working directory.





