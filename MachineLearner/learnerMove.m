function [ output_args ] = learnerMove( input_args )
global moveSuccess;
global board;
%LEARNERMOVE Summary of this function goes here
%   Detailed explanation goes here

% First, load the stored moves (maybe do this in the playconnet4 method so
% it's only done once. If so, use a global var.)

% Next, read the current board state and determine the 7 possible next
% moves it can make. Check to see the success of those moves previously.
% Take the highest scoring one and execute it.

% Add the chosen move to the list of moves taken this game (need global var
% for this)


end

