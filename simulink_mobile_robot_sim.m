load exampleMaps.mat
path = [2.00    1.00;
        1.25    1.75;
        5.25    8.25;
        7.25    8.75;
        11.75   10.75;
        12.00   10.00];
startLoc=path(1,:);goalLoc=path(end,:);
open_system("pathPlanningSimulinkModel.slx")
sim_out=sim("pathPlanningSimulinkModel.slx");
map=binaryOccupancyMap(simpleMap);
Pose=sim_out.Pose;
indx=3;
Pose(:,indx)=0;
Theta=Pose(:,indx);
Theta2Euler=zeros(size(Pose,1),3*size(Theta,2));
Theta2Euler(:,end)=Theta;
sample_time=0.1;
r=rateControl(1/sample_time);
for k = 1:10:size(Pose, 1) 
    show(map)
    hold on;
    
    % Plot the start location.
    plotTransforms([startLoc, 0], eul2quat([0, 0, 0]))
    
    % Plot the goal location.
    plotTransforms([goalLoc, 0], eul2quat([0, 0, 0]))
   
    
    % Plot the xy-locations.
    plot(Pose(:, 1),Pose(:, 2), '-b')
    
    % Plot the robot pose as it traverses the path.
    quat = eul2quat(Theta2Euler(k, :), 'xyz');
    plotTransforms(Pose(k,:), quat, 'MeshFilePath',...
        'groundvehicle.stl');
    light;
    drawnow;
    waitfor(r)
    hold off;
end


