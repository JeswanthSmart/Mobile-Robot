clc
clear all
close all
%% define the publisher and the subscriber nodes %%
% rosinit
pub=rospublisher("/chatter","std_msgs/String");
message=rosmessage(pub);
sub=rossubscriber("/chatter","std_msgs/String",@roscallback);
message.Data="reduce speed";
send(pub,message)
pause(2)
