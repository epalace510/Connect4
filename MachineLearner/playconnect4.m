function playconnect4()
%Playconenct4 Draw the connect four board
% This is skeleton code for project 2 - connect four minimax for AI CSC 380
% Skeleton code provided by Edward Kim modified from draw code written by Mickey Stahl
global board;
global prevboard;
global ax;
global whoseturn;
global solved;
global moveSuccess;
solved=0;

%Size of the board...
board=zeros(6,7);

%need a snapshot for move tracking
prevboard=zeros(6,7);

%which player's turn
whoseturn = 1;
%disp('Your turn');

% Reading in the file containing the values of past moves.
%PROBLEM: CELL ARRAY IS UNHAPPY
% specifically, the dimensions don't match when cat-ing and it's tricky to
% make equality work (though it seems to work right now).
fileID=fopen('moves.dat');
moveSuccess=textscan(fileID,'%s %d %d');
fclose(fileID);

%Draw code
%This line will call the click function when the mouse button is pressed.
%Comment out for learning trials.
% figure('WindowButtonDownFcn',@click)
% Draw code. Don't want this while learning either.
% ax = axes('DrawMode','fast');
% [r,c]=size(board);
% radius=0.35;
% t=-pi/2:0.01:pi/2;
% x1=[0 0 radius.*cos(t) 0 0 0.5 0.5 0];
% y1=[-0.5 -radius radius.*sin(t) radius 0.5 0.5 -0.5 -0.5];
% x2=[0 0 -radius.*cos(t) 0 0 -0.5 -0.5 0];
% for j=1:c,
%     for k=1:r,
%         patch(x1+j-0.5,y1+r-k+0.5,'b','edgecolor','none'),axis equal
%         patch(x2+j-0.5,y1+r-k+0.5,'b','edgecolor','none')
%     end
% end
% axis([0 c 0 r],'equal','off')
% This should just run until the game has been won.
    while solved==0
        click;
    end
    % This should be the logic for either incentivising or disincentivising a
% move
if(solved==1)
    for(i=1:size(movesTaken,1))
        [row,col]=find(moveSuccess==movesTaken(1,i));
        moveSuccess(row,3)=moveSuccess(row,3)+1;
    end
elseif(solved==2)
    for(i=1:size(movesTaken,1))
        [row,col]=find(moveSuccess==movesTaken(1,i));
        moveSuccess(row,2)=moveSuccess(row,2)+1;
        moveSuccess(row,3)=moveSuccess(row,3)+1;
    end
end
%Writing the updated version of how moves did to the file.
% This is only done at the end of the session, so this write only ever
% occurs once per session (important during testing when a session can
% include >1000 games)
[nrows,ncols]=size(moveSuccess);
fileID=fopen('moves.dat','w');
for row=1:nrows
    fprintf(fid,'%s %d %d\n', moveSuccess{row,:});
end
end

