function quad_vis

%[t,x,y,z,roll,pitch,yaw,M1_t,M2_t,M3_t,M4_t] 
Cen_pos = cell2mat(struct2cell(load('quad_pos.mat')));
Cen_pos = Cen_pos';
wb = .6;

    mov = VideoWriter('test.avi');
    open(mov);

    max_t = [max(Cen_pos(:,8));
             max(Cen_pos(:,9));
             max(Cen_pos(:,10));
             max(Cen_pos(:,11));];
         
    max_t = max(max_t)/10;

    figure('Name','Quadcopter Flight Path')
    hold on; 

    for i = 2:6:length(Cen_pos)  % check number of loops before saving video
        
       %--------------Rotation--------- 
           R_roll = sym([1 0 0 0; 
                         0 cos(Cen_pos(i,5)) -sin(Cen_pos(i,5)) 0; 
                    0 sin(Cen_pos(i,5)) cos(Cen_pos(i,5)) 0; 
                    0 0 0 1]);

           R_pitch = sym([cos(Cen_pos(i,6)) 0 sin(Cen_pos(i,6)) 0;
                      0 1 0 0;
                      -sin(Cen_pos(i,6)) 0 cos(Cen_pos(i,6)) 0;
                      0 0 0 1]);

           R_yaw = sym([cos(Cen_pos(i,7)) -sin(Cen_pos(i,7)) 0 0; 
                    sin(Cen_pos(i,7))  cos(Cen_pos(i,7)) 0 0; 
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
                             0 1 0 -wb; 
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
                             0 1 0 wb; 
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
       
       
       %vector and arrow colors
       [c1,p1,c2,p2,c3,p3,c4,p4] = t_color(Cen_pos(i,8),Cen_pos(i,9),Cen_pos(i,10),Cen_pos(i,11));
       
       %plot Motor thrust vectors
       plot3([M1_pos(1) M1_t_pos(1)],[M1_pos(2) M1_t_pos(2)],[M1_pos(3) M1_t_pos(3)],c1)
       plot3([M2_pos(1) M2_t_pos(1)],[M2_pos(2) M2_t_pos(2)],[M2_pos(3) M2_t_pos(3)],c2)
       plot3([M3_pos(1) M3_t_pos(1)],[M3_pos(2) M3_t_pos(2)],[M3_pos(3) M3_t_pos(3)],c3)
       plot3([M4_pos(1) M4_t_pos(1)],[M4_pos(2) M4_t_pos(2)],[M4_pos(3) M4_t_pos(3)],c4)
       
       %plot thurst arrows
       plot3([M1_t_pos(1)],[M1_t_pos(2)],[M1_t_pos(3)],p1,'MarkerSize',5)
       plot3([M2_t_pos(1)],[M2_t_pos(2)],[M2_t_pos(3)],p2,'MarkerSize',5)
       plot3([M3_t_pos(1)],[M3_t_pos(2)],[M3_t_pos(3)],p3,'MarkerSize',5)
       plot3([M4_t_pos(1)],[M4_t_pos(2)],[M4_t_pos(3)],p4,'MarkerSize',5)
       
        %hold off
            view(90,0)
            axis([-3 3 -3 3 17 23])
            grid on;
            title('Quadcopter Model (World Frame)')
            xlabel('X Dist (m)')
            ylabel('Y Dist (m)')
            zlabel('Z Dist (m)')
            
       d = 0;
       for d = 1:1  % playback "speed"
         currFrame = getframe;
         %writeVideo(mov,currFrame);  %uncomment to save video file
         d = d+1;
       end
    end
end

function [c1,p1,c2,p2,c3,p3,c4,p4] = t_color(T1,T2,T3,T4)
hover_min = 8.8;
hover_max = 9.1;

   %Motor 1
       if T1<hover_min
           c1 = 'b-';
           p1 = 'b^';
       end
       if (hover_min <= T1) &&  (T1<= hover_max)
           c1 = 'g-';
           p1 = 'g^';
       end
       if  (T1>hover_max)
           c1 = 'r-';
           p1 = 'r^';  
       end

   %Motor 2
       if T2<hover_min
           c2 = 'b-';
           p2 = 'b^';
       end
       if (hover_min <= T2) &&  (T2<= hover_max)
           c2 = 'g-';
           p2 = 'g^';
       end
       if  (T2>hover_max)
           c2 = 'r-';
           p2 = 'r^';  
       end       
       
   %Motor 3
       if T3<hover_min
           c3 = 'b-';
           p3 = 'b^';
       end
       if (hover_min <= T3) &&  (T3<= hover_max)
           c3 = 'g-';
           p3 = 'g^';
       end
       if  (T3>hover_max)
           c3 = 'r-';
           p3 = 'r^';  
       end       

  %Motor 4
       if T4<hover_min
           c4 = 'b-';
           p4 = 'b^';
       end
       if (hover_min <= T4) &&  (T4<= hover_max)
           c4 = 'g-';
           p4 = 'g^';
       end
       if  (T4>hover_max)
           c4 = 'r-';
           p4 = 'r^';  
       end              
end