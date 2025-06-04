
clc;
clear;

runs = 10000000; %no of desired runs

target = 50;
curr_pos = 0;
speed = 0;
gain = 0.01; % Adjust this to different gain values
del_t = 0.001; % delta time, that is observations are made for every 0.001th sec

count = 1;

tolerance = 10^-6; 

error = target - curr_pos;
error_vals = zeros(1,runs);
speed_vals = zeros(1,runs);
distance_vals = zeros(1, runs);

while count <= runs & error >= tolerance
    speed = gain * error;
    curr_pos = curr_pos + speed * del_t;
    error = target - curr_pos;

    error_vals(count) = error;
    speed_vals(count) = speed;
    distance_vals(count) = curr_pos;

    count = count + 1;
end

decay_time = (count-1) * del_t;

time = 1:1:count;
figure(1);

subplot(3,1,1);
plot(time, error_vals(1:count), 'LineStyle','-', 'LineWidth', 2); 
ylabel('error(in m)');
xlabel('time');
title(sprintf("Proportional - Controller : Error, (gain = %.7f), (runs = %d), (decay time = %.7f)", gain, runs, decay_time));

subplot(3,1,2);
plot(time, speed_vals(1:count), 'LineStyle',':', 'LineWidth', 2);
title(sprintf("Proportional - Controller: Speed, (gain = %.7f), (runs = %d)", gain, runs));
ylabel('speed(in m/s)');
xlabel('time');

subplot(3,1,3);
plot(time, distance_vals(1:count), 'LineStyle','-.', 'LineWidth', 2);
title(sprintf("Proportional - Controller: Distance, (gain = %.7f), (runs = %d)", gain, runs));
ylabel('distance (in m)');
xlabel('time');

grid on;

