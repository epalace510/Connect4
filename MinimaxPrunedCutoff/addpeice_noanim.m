function addpeice_noanim()
%ADDPEICE_NOANIM No aimation scirpt
%   Detailed explanation goes here

global board;
global prevboard;

[r,c]=size(board);
radius=0.35;
t=0:0.01:2*pi;
x=radius.*cos(t);
y=radius.*sin(t);
[m,n]=find(board~=prevboard);
colors=[1 0 0;0 0 0];
finish=r-m+0.5;
h=patch(x+n-0.5,finish,colors(board(m,n),:));
set(h,'ydata',y+finish);
drawnow;
prevboard=board;
end

