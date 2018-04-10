function quad_vis

%[x,y,z,yaw,roll,pitch] 
Cen_pos = cell2mat(struct2cell(load('quad_pos.mat')));

%     mov = VideoWriter('test.avi');
%     open(mov);
    figure ('Name','Quadcopter Flight Path')
    hold on; 

    for i = 1:length(Cen_pos)
        
       %--------------Rotation--------- 
           R_roll = sym([1 0 0 0; 
                         0 cos(Cen_pos(i,5)) -sin(Cen_pos(i,5)) 0; 
                    0 sin(Cen_pos(i,5)) cos(Cen_pos(i,5)) 0; 
                    0 0 0 1]);

           R_pitch = sym([cos(Cen_pos(i,6)) 0 sin(Cen_pos(i,6)) 0;
                      0 1 0 0;
                      -sin(Cen_pos(i,6)) 0 cos(Cen_pos(i,6)) 0;
                      0 0 0 1]);

           R_yaw = sym([cos(Cen_pos(i,4)) -sin(Cen_pos(i,4)) 0 0; 
                    sin(Cen_pos(i,4))  cos(Cen_pos(i,4)) 0 0; 
                    0 0 1 0; 
                    0 0 0 1]);

           Rot = R_roll*R_pitch*R_yaw;
       %-----------------------
         
       %----------Motor 1 Translation---------
             M1_trans = Rot*[1 0 0 wb; 
                             0 1 0 0; 
                             0 0 1 0; 
                             0 0 0 1];

                    %X,Y,Z
            M1_pos = [(Cen_pos(i,1)+(M1_trans(1,4))),...
                      (Cen_pos(i,2)+(M1_trans(2,4))),...
                      (Cen_pos(i,3)+(M1_trans(3,4)))];
       %----------------------- 

       
       %----------Motor 2 Translation---------
             M2_trans = Rot*[1 0 0 0; 
                             0 1 0 wb; 
                             0 0 1 0; 
                             0 0 0 1];

                    %X,Y,Z
            M2_pos = [(Cen_pos(i,1)+(M2_trans(1,4))),...
                      (Cen_pos(i,2)+(M2_trans(2,4))),...
                      (Cen_pos(i,3)+(M2_trans(3,4)))];
       %----------------------- 
               
       
       %----------Motor 3 Translation---------
             M3_trans = Rot*[1 0 0 -wb; 
                             0 1 0 0; 
                             0 0 1 0; 
                             0 0 0 1];

                    %X,Y,Z
            M3_pos = [(Cen_pos(i,1)+(M3_trans(1,4))),...
                      (Cen_pos(i,2)+(M3_trans(2,4))),...
                      (Cen_pos(i,3)+(M3_trans(3,4)))];
       %-----------------------        
       
       %----------Motor 4 Translation---------
             M4_trans = Rot*[1 0 0 0; 
                             0 1 0 -wb; 
                             0 0 1 0; 
                             0 0 0 1];

                    %X,Y,Z
            M4_pos = [(Cen_pos(i,1)+(M4_trans(1,4))),...
                      (Cen_pos(i,2)+(M4_trans(2,4))),...
                      (Cen_pos(i,3)+(M4_trans(3,4)))];
       %-----------------------          
       
       clf;
       hold all;
       plot3([Cen_pos(i,1) M1_pos(1)],[Cen_pos(i,2) M1_pos(2)],[Cen_pos(i,3) M1_pos(3)],'r-')
       plot3([Cen_pos(i,1) M2_pos(1)],[Cen_pos(i,2) M2_pos(2)],[Cen_pos(i,3) M2_pos(3)],'b-')
       plot3([Cen_pos(i,1) M3_pos(1)],[Cen_pos(i,2) M3_pos(2)],[Cen_pos(i,3) M3_pos(3)],'g-')
       plot3([Cen_pos(i,1) M4_pos(1)],[Cen_pos(i,2) M4_pos(2)],[Cen_pos(i,3) M4_pos(3)],'k-')
        hold off
            view(-90,0)
            axis([-5 5 -5 5 35 55])
            grid on;
            title('Test')
            xlabel('X Dist (m)')
            ylabel('Y Dist (m)')
            zlabel('Z Dist (m)')
            
       d = 0;
       for d = 1:1  % playback "speed"
         currFrame = getframe;
       %  writeVideo(mov,currFrame);
         d = d+1;
       end
    end
end