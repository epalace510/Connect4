function addpeice()
%ADDPEICE animation for dropping a peice in the connect 4 board
%   
global board;
global prevboard;
global ax;

[r,c]=size(board);
radius=0.35;
t=0:0.01:2*pi;
x=radius.*cos(t);
y=radius.*sin(t);
% find where to put the peice
[m,n]=find(board~=prevboard);
colors=[1 0 0;0 0 0];
start=r+1;
finish=r-m+0.5;
%drop step size
step=0.5;
h=patch(x+n-0.5,start,colors(board(m,n),:));
% the following lines makes the peice go behind the board
kids=get(ax,'children');
set(ax,'children',[kids(2:end);kids(1)])

% drop the peice in place
fall=start;
while fall>finish & ishandle(h)
    fall=fall-step;
    set(h,'ydata',y+fall);
    drawnow;
end
% set the board state
prevboard=board;

end

