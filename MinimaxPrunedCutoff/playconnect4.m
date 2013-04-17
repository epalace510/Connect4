function playconnect4()
%Playconenct4 Draw the connect four board
% This is skeleton code for project 2 - connect four minimax for AI CSC 380
% Skeleton code provided by Edward Kim modified from draw code written by Mickey Stahl
global board;
global prevboard;
global ax;
global whoseturn;
global solved;
solved=0;

%Size of the board...
board=zeros(6,7);

%need a snapshot for move tracking
prevboard=zeros(6,7);

%which player's turn
whoseturn = 1;
disp('Your turn');

%Draw code
figure('WindowButtonDownFcn',@click)
ax = axes('DrawMode','fast');
[r,c]=size(board);
radius=0.35;
t=-pi/2:0.01:pi/2;
x1=[0 0 radius.*cos(t) 0 0 0.5 0.5 0];
y1=[-0.5 -radius radius.*sin(t) radius 0.5 0.5 -0.5 -0.5];
x2=[0 0 -radius.*cos(t) 0 0 -0.5 -0.5 0];
for j=1:c,
    for k=1:r,
        patch(x1+j-0.5,y1+r-k+0.5,'b','edgecolor','none'),axis equal
        patch(x2+j-0.5,y1+r-k+0.5,'b','edgecolor','none')
    end
end
axis([0 c 0 r],'equal','off')
end

