close all
clc
clear all

addpath('../plot_tools/');
close all
filler_height = 10;
filename = sprintf('data/result_bcsphere_input_position_%02.0fcm.csv', filler_height);
result = csvread(filename);
time = result(:,1);
position = result(:,2);
velo = result(:,3);
acc = result(:,4);

[t_contact_start, index_start] = findCollisionStartTime(acc, time);

initial_position = position(index_start);

% throw away useless data
time = time(index_start:end);
position = position(index_start:end);
velo = velo(index_start:end);
acc = acc(index_start:end);


LW = 2;
FS = 25;

figure;
subplot(3,1,1)
makePlot(time - t_contact_start, acc, 'time(sec)', 'acceleration(m/s^2)', sprintf("filling height %.0f cm", filler_height), LW, FS);
grid on

subplot(3,1,2)
makePlot(time - t_contact_start, velo, 'time(sec)', 'velocity(cm/s)', '', LW, FS)
grid on

subplot(3,1,3)
makePlot(time - t_contact_start, position - initial_position, 'time(sec)', 'penetration (cm)', sprintf('penetration = %.2f cm', position(end) - initial_position), LW, FS)
grid on


% given acceleration find out the time when contact
% start and the index of such contact
function [t_c, index_start] = findCollisionStartTime(acc, time)
for i = 1:length(acc)
    if abs(acc(i) + 9.8) > 0.01
        t_c = time(i);
        index_start = i;
        break;
    end
end
end


% result = csvread('data/result_meshsphere_input_position_14cm.csv');
% t = result(:,1);
% penetration = result(:,2);
% velo = result(:,3);
% acc = result(:,4);
%
% subplot(3,1,1)
% hold on
% makePlot(t-t(1), acc, 'time(sec)', 'acceleration(m/s^2)', 'filling height 5cm', LW, FS);
% xlim([0.1,0.3])
% grid on
%
% subplot(3,1,2)
% hold on
% makePlot(t-t(1), velo, 'time(sec)', 'velocity(cm/s)', '', LW, FS)
% xlim([0.1,0.3])
% grid on
%
% subplot(3,1,3)
% hold on
% makePlot(t-t(1), penetration, 'time(sec)', 'penetration (cm)', '', LW, FS)
% xlim([0.1,0.3])
% grid on
