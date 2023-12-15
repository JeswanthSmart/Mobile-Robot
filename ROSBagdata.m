clc
clear all
close all
% % bag=rosbag("ros_turtlesim.bag");
% % selected_topic=select(bag,"Topic","/turtle1/pose");
% % message=readMessages(selected_topic,"DataFormat","struct");
%% read scan data from ros bag %%
bag1=rosbag("path_record.bag");
circle_plot=select(bag1,"Topic","/circle");
message_line=readMessages(circle_plot,"DataFormat","struct");
%% displaying the linear path of robot motion %
 xdata=cellfun(@(t)(t.X),message_line);
 ydata=cellfun(@(t)(t.Y),message_line);
 plot(xdata,ydata)









