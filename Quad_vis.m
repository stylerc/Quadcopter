function quad_vis

%[t,x,y,z,yaw,roll,pitch,M1_t,M2_t,M3_t,M4_t] 
Cen_pos = cell2mat(struct2cell(load('quad_pos.mat')));
Cen_pos = Cen_pos';
wb = .6;

%     mov = VideoWriter('test.avi');
%     open(mov);

    max_t = [max(Cen_pos(:,8));
             max(Cen_pos(:,9));
             max(Cen_pos(:,10));
             max(Cen_pos(:,11));];
         
    max_t = max(max_t)/4;

    figure('Name','Quadcopter Flight Path')
    hold on; 

    for i = 2:10 %length(Cen_pos)
        
       %--------------Rotation--------- 
           R_roll = sym([1 0 0 0; 
                         0 cos(Cen_pos(i,6)) -sin(Cen_pos(i,6)) 0; 
                    0 sin(Cen_pos(i,6)) cos(Cen_pos(i,6)) 0; 
                    0 0 0 1]);

           R_pitch = sym([cos(Cen_pos(i,7)) 0 sin(Cen_pos(i,7)) 0;
                      0 1 0 0;
                      -sin(Cen_pos(i,7)) 0 cos(Cen_pos(i,7)) 0;
                      0 0 0 1]);

           R_yaw = sym([cos(Cen_pos(i,5)) -sin(Cen_pos(i,5)) 0 0; 
                    sin(Cen_pos(i,5))  cos(Cen_pos(i,5)) 0 0; 
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
            M1_pos = [(Cen_pos(i,2)+(M1_trans(1,4))),...
                      (Cen_pos(i,3)+(M1_trans(2,4))),...
                      (Cen_pos(i,4)+(M1_trans(3,4)))];
                  
                         
            M1_t_pos = [M1_pos(1)+0,...
                        M1_pos(2)+0,...
                        M1_pos(3)+(Cen_pos(i,8)/max_t)];
            
       %----------------------- 

       
       %----------Motor 2 Translation---------
             M2_trans = Rot*[1 0 0 0; 
                             0 1 0 wb; 
                             0 0 1 0; 
                             0 0 0 1];

                    %X,Y,Z
            M2_pos = [(Cen_pos(i,2)+(M2_trans(1,4))),...
                      (Cen_pos(i,3)+(M2_trans(2,4))),...
                      (Cen_pos(i,4)+(M2_trans(3,4)))];
                  
            M2_t_pos = [M2_pos(1)+0,...
                        M2_pos(2)+0,...
                        M2_pos(3)+(Cen_pos(i,9)/max_t)];
       %----------------------- 
               
       
       %----------Motor 3 Translation---------
             M3_trans = Rot*[1 0 0 -wb; 
                             0 1 0 0; 
                             0 0 1 0; 
                             0 0 0 1];

                    %X,Y,Z
            M3_pos = [(Cen_pos(i,2)+(M3_trans(1,4))),...
                      (Cen_pos(i,3)+(M3_trans(2,4))),...
                      (Cen_pos(i,4)+(M3_trans(3,4)))];
                  
            M3_t_pos = [M3_pos(1)+0,...
                        M3_pos(2)+0,...
                        M3_pos(3)+(Cen_pos(i,10)/max_t)];
       %-----------------------        
       
       %----------Motor 4 Translation---------
             M4_trans = Rot*[1 0 0 0; 
                             0 1 0 -wb; 
                             0 0 1 0; 
                             0 0 0 1];

                    %X,Y,Z
            M4_pos = [(Cen_pos(i,2)+(M4_trans(1,4))),...
                      (Cen_pos(i,3)+(M4_trans(2,4))),...
                      (Cen_pos(i,4)+(M4_trans(3,4)))];
                  
            M4_t_pos = [M4_pos(1)+0,...
                        M4_pos(2)+0,...
                        M4_pos(3)+(Cen_pos(i,11)/max_t)];
       %-----------------------          
       
       clf;
       hold all;
       
       %plot quad center
       plot3(Cen_pos(i,2), Cen_pos(i,3), Cen_pos(i,4),'bo')
       
       %plot armsof quad
       plot3([Cen_pos(i,2) M1_pos(1)],[Cen_pos(i,3) M1_pos(2)],[Cen_pos(i,4) M1_pos(3)],'b-')
       plot3([Cen_pos(i,2) M2_pos(1)],[Cen_pos(i,3) M2_pos(2)],[Cen_pos(i,4) M2_pos(3)],'c-')
       plot3([Cen_pos(i,2) M3_pos(1)],[Cen_pos(i,3) M3_pos(2)],[Cen_pos(i,4) M3_pos(3)],'g-')
       plot3([Cen_pos(i,2) M4_pos(1)],[Cen_pos(i,3) M4_pos(2)],[Cen_pos(i,4) M4_pos(3)],'k-')
       
       %plot Motor thrust vectors
       plot3([M1_pos(1) M1_t_pos(1)],[M1_pos(2) M1_t_pos(2)],[M1_pos(3) M1_t_pos(3)],'r-')
       plot3([M2_pos(1) M2_t_pos(1)],[M2_pos(2) M2_t_pos(2)],[M2_pos(3) M2_t_pos(3)],'r-')
       plot3([M3_pos(1) M3_t_pos(1)],[M3_pos(2) M3_t_pos(2)],[M3_pos(3) M3_t_pos(3)],'r-')
       plot3([M4_pos(1) M4_t_pos(1)],[M4_pos(2) M4_t_pos(2)],[M4_pos(3) M4_t_pos(3)],'r-')
       
       %plot thurst arrows
       plot3([M1_t_pos(1)],[M1_t_pos(2)],[M1_t_pos(3)],'r^','MarkerSize',5)
       plot3([M2_t_pos(1)],[M2_t_pos(2)],[M2_t_pos(3)],'r^','MarkerSize',5)
       plot3([M3_t_pos(1)],[M3_t_pos(2)],[M3_t_pos(3)],'r^','MarkerSize',5)
       plot3([M4_t_pos(1)],[M4_t_pos(2)],[M4_t_pos(3)],'r^','MarkerSize',5)
       
        hold off
            view(-20,45)
            axis([-2 2 -2 2 30 70])
            grid on;
            title('Quadcopter Model (World Frame)')
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