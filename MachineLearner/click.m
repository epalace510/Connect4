function [ output_args ] = click( src,evt )
%CLICK Summary of this function goes here
%   Detailed explanation goes here
global ax;
global board;
global whoseturn;
global solved;

if(solved==0)
%     Code for the human player to make a move. In learning process, we
% %     aren't using a human.
% point=get(ax,'currentpoint');
% point=point(1,1:2);
% [r,c]=size(board);
% if point(1)>0 & point(1)<c & point(2)>0 & point(2)<r,
%     point=floor(point)+1;
%     whoseturn=1;
%     if board(1,point(1))~=0
%         result=0;
%         return
%     end
%     
%     %Find where to put the next piece
%     
%     for j=1:size(board,1),
%         if board(j,point(1))~=0
%             j=j-1; 
%             break;
%         end
%     end
%     board(j,point(1))=whoseturn;
%     %addpeice_noanim;
%     addpeice;

% Instead of a human, we're using the minimax AI to play as the human
% during the learning process.
    minimaxmove;
    disp('My Turn.');
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%% You have made your move %%%%%%
    %%%% Now let the computer move %%%%
    %%%% Add code here             %%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    learnerMove;
    %addpeice_noanim;
%     if(solved~=1)
%     addpeice;
%     end
    if(solved==0)
        disp('Your turn');
    end
    
end
end
% end

