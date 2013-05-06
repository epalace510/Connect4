function [ output_args ] = learnerMove( input_args )
global moveSuccess;
global board;
global movesTaken;
%LEARNERMOVE Summary of this function goes here
%   Detailed explanation goes here

% First, load the stored moves (done in playconnect4 into the moveSuccess
% global var).

% Next, read the current board state and determine the 7 possible next
% moves it can make. Check to see the success of those moves previously.
% Take the highest scoring one and execute it.
%array(row,column)

score=0;
for i=1:7
    tempBoard=board;
    for l=1:size(tempBoard,1),
        if(l>0)
            if tempBoard(l,i)~=0
                l=l-1;
                break;
            end
        end
    end
    %Set the next possible move
    tempBoard(l,i)=2;
    %Reduce it to a 1 dimensional integer
    state=cat(2,tempBoard(:,1),tempBoard(:,2),tempBoard(:,3),tempBoard(:,4),tempBoard(:,5),tempBoard(:,6),tempBoard(:,7));
    state=int2str(state);
    %Find the score of the move.
    [row,col]=find(ismember(moveSuccess{:,1}, state)==1);
    if(~isempty(row))
        %Calculate the percentage won.
        tscore=moveSuccess(row,2)/moveSuccess(row,3);
    else
        %Create an entry for this state since we've never visited it
        %before. Give it 1/7 times won.
        tscore=1/7;
        newEntry=[state,1,7];
        moveSuccess=cat(1,moveSuccess,newEntry);
    end
    if tscore>score
        nextBoard=tempBoard;
    end
end

% Add the chosen move to the list of moves taken this game (need global var
% for this)
board=nextBoard;
state=cat(2,nextBoard(:,1),nextBoard(:,2),nextBoard(:,3),nextBoard(:,4),nextBoard(:,5),nextBoard(:,6),nextBoard(:,7));
movesTaken=cat(1,movesTaken,state);

end

