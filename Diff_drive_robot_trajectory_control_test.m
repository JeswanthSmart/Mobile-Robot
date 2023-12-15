clc
clear all
close all
%% define the path to traverse %%
% %path = [2.00    1.00;
%         1.25    1.75;
%         5.25    8.25;
%         7.25    8.75;
%         11.75   10.75;
%         12.00   10.00];
r=1.5;
theta=-2*pi:pi/12:2*pi;
x=r*cos(theta);
y=r*sin(theta);
x=x';
y=y';
path=[x(1:15,:),y(1:15,:)];
%% construct the robot dynamics %%
robot=differentialDriveKinematics("TrackWidth",1,"VehicleInputs","VehicleSpeedHeadingRate");
%% Initialization of current and the final pos %%
Initial_pos=path(1,:);
Initial_ore=0;
Curr_pos=[Initial_pos,Initial_ore]';
%% goal point and the deviation from goal %%
Goal=path(end,:);
err=norm(Initial_pos-Goal);
controller=controllerPurePursuit;
controller.Waypoints=path;
controller.MaxAngularVelocity=12;
controller.LookaheadDistance=0.2;
controller.DesiredLinearVelocity=1;
objective=0.1;
Sample_Time=0.1;
rate=rateControl(1/Sample_Time);
figure()
frameSize=robot.TrackWidth;
%% start the main loop for path planning %%
while(err>objective)
[vel,omega]=controller(Curr_pos);
vel=derivative(robot,Curr_pos,[vel,omega]);
Curr_pos=Curr_pos+vel*Sample_Time;
err=norm(Curr_pos(1:2)-Goal');
hold off
plot(path(:,1),path(:,2),'--k')
hold all
Trvec=[Curr_pos(1:2);0];
rot=axang2quat([0,0,1,Curr_pos(3)]);
plotTransforms(Trvec',rot,"MeshFilepath","groundvehicle.stl","Parent",gca,"view","2D",...
    "FrameSize",frameSize);
waitfor(rate)
end



