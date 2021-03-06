function computermove()
    %COMPUTERMOVE This is where you make the computer move
    %   Set the board position.  Make sure the computer gets a value of "2" in
    %   the board
    global board;
    global ax;
    global solved;

    %FYI this would set the board at row 6, column 1 to computers move... "2"
    %board(6,1) = 2;

    %HERE IS WHERE I CODE
    %Similar to DFS, create a queue based on theoretical moves. Then use some
    %metric to evaluate how good each move is.

    [span,multiple,functions]=check4win(board);
    if(span==1)
        disp('You Win! Congrats!');
        solved=1;
    elseif(span==2)
        disp('I win! Better luck next time.');
        solved=2;
    elseif(span==3)
        disp('We tie! Good Game!');
        solved=3;
    end
    if(span==0)
        nextMove=Minimax(1,board,2);
        board=nextMove;
    end
    [span,multiple,functions]=check4win(board);
    if(span==2)
        disp('I win! Better luck next time.');
        solved=2;
    end


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%% Code to check for a winner... will return winner 1 or 2 or
    %%%%%%%%%% 0 if no win, 3 if tie
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function [w,ind,num] = check4win(b)

    [w,ind,num]=checkplayer(b,1);
    if w==0,[w,ind]=checkplayer(b,2); end
    if isempty(find(b==0)) & w==0,w=3;end

    end

    function [w,ind,num]=checkplayer(board,player)

        [r,c]=find(board==player);
        horz_step=[-1 0 1 1 1 0 -1 -1];
        vert_step=[1 1 1 0 -1 -1 -1 0];
        w=0;
        ind=[];
        num=[];
        for j=1:length(r),
            for k=1:8,
                if r(j)-3*vert_step(k)>0 & r(j)-3*vert_step(k)<=size(board,1) & c(j)+3*horz_step(k)>0 & c(j)+3*horz_step(k)<=size(board,2),
                    if vert_step(k)~=0,
                        checkrows=r(j):-vert_step(k):r(j)-3*vert_step(k);
                    else
                        checkrows=r(j).*ones(1,4);
                    end
                    if horz_step(k)~=0,
                        checkcols=c(j):horz_step(k):c(j)+3*horz_step(k);
                    else
                        checkcols=c(j).*ones(1,4);
                    end
                    for m=1:4,
                        group(m)=board(checkrows(m),checkcols(m));
                    end
                    num=cat(1,group,num);
                    if sum(abs(group-player))==0,

                        ind=[checkrows;checkcols];
                        w=player;
                        return
                    end
                end
            end
        end
    end
    function [bArray,parents,oScore]=DFS(iter,tBoard,turn,root)
        bArray=double.empty;
        if(root~=0)
            parents=root;
        end
        otherTurn=turn;
        oScore=double.empty;
        scores=double.empty;
        tPar=[];
        for n=1:7
            score=double.empty;
            if(iter==1)
                parents=n;
            end
            tempBoard=tBoard;
            for l=1:size(tempBoard,1),
                if(l>0)
                    if tempBoard(l,n)~=0
                        l=l-1;
                        break;
                    end
                end
            end
            if(l<=0)
                if(otherTurn==1)
                    scores=cat(1,intmax,scores);
                    bArray=cat(1,tempBoard,bArray);
                    tPar=cat(1,parents,tPar);
                else
                    scores=cat(1,-intmax,scores);
                    bArray=cat(1,tempBoard,bArray);
                    tPar=cat(1,parents,tPar);
                end
            else
            tempBoard(l,n)=otherTurn;
            %Get the num of connections here. The number of pieces in a row
            %are the heuristic I used to determine how good/bad the board was.
            [w,ind,num]=check4win(tempBoard);
            tscore=0;
            for k=1:size(num,1)
                if(~isempty(num))
                    t=num(k,1);
                    for dex=2:4
                        if(num(k,dex)~=t)
                            break;
                        end
                        if(t==2)
                            tscore=tscore+1;
                        elseif(t==1)
                            tscore=tscore-1;
                        end
                    end
                end
            end
            %Just assigning stupidly large numbers so the AI *KNOWS* they're
            %important
            if(w==1)
                tscore=tscore-10000;
            end
            if(w==2)
                tscore=tscore+100;
            end
            %If the move of the board is solved, don't recurse more.
            %Instead, break out of the loop and return this state instead
            %of its children.
            if(w~=0)
                scores=cat(1,tscore,scores);
                bArray=cat(1,tempBoard,bArray);
                tPar=cat(1,parents,tPar);
                break;
            end
            %Pruning by checking for less than min (if trying to min)
            if(otherTurn==1)
              if(~isempty(score))
                if(tscore<score)
                  score=tscore;
                  if iter<4 && w==0
                    [rBAr,rPar,tScore]=DFS(iter+1,tempBoard,2,parents);
                    scores=cat(1,tScore,scores);
                    bArray=cat(1,rBAr,bArray);
                    tPar=cat(1,rPar,tPar);
                  elseif iter==4
                    bArray=cat(1,tempBoard,bArray);
                  end
                end
                %if the score is empty (ie if there's no basis for cutoff, then establish it as the basis and run through its children.
              else
                  score=tscore;
                  if iter<4 && w==0
                    [rBAr,rPar,tScore]=DFS(iter+1,tempBoard,2,parents);
                    scores=cat(1,tScore,scores);
                    bArray=cat(1,rBAr,bArray);
                    tPar=cat(1,rPar,tPar);
                  elseif iter==4
                    bArray=cat(1,tempBoard,bArray);
                  end
              end
            else
                    %Pruning by checking for greater than max (if trying to
                    %max)
              if(~isempty(score))
                    if(tscore>score)
                        score=tscore;
                        if iter<4 && w==0
                            [rBAr,rPar,tScore]=DFS(iter+1,tempBoard,1,parents);
                            scores=cat(1,tScore,scores);
                            bArray=cat(1,rBAr,bArray);
                            tPar=cat(1,rPar,tPar);
                        elseif iter==4
                            bArray=cat(1,tempBoard,bArray);
                        end
                    end
                %if the score is empty (ie if there's no basis for cutoff, then establish it as the basis and run through its children.
              else
                        score=tscore;
                        if iter<4 && w==0
                            [rBAr,rPar,tScore]=DFS(iter+1,tempBoard,1,parents);
                            scores=cat(1,tScore,scores);
                            bArray=cat(1,rBAr,bArray);
                            tPar=cat(1,rPar,tPar);
                        elseif iter==4
                            bArray=cat(1,tempBoard,bArray);
                        end
              end
                end
                %For the lowest level of iteration, don't iterate more.
                %Just return the values of the states.
                if(iter==4)
                    tPar=cat(1,parents,tPar);
                    scores=cat(1,tscore,scores);
                end
            end
        end
        %Choosing the move
        %Output of the actual chosen move
        %Only the deepest states have their values computed.
        %Take either the min or the max (depending on who is going). Then
        %return that choice's score along with it's parent (the row the
        %tile would be originally placed in).
        if(otherTurn==1)
            index=find(scores==min(scores),1);
            oScore=min(scores);
            oScore=unique(oScore);
        else
            index=find(scores==max(scores),1);
            oScore=max(scores);
            oScore=unique(oScore);
        end
        bArray=bArray(((index-1)*6)+1:((index-1)*6)+6,:);
        parents=tPar(index);
        return
    end
    function nextBoard = Minimax(iter,tBoard,turn)
    %This function doesn't do much, but I thought it would have more
    %use than it did when I started the project.
    [boardArray,parentArray,rScore]=DFS(iter,tBoard,turn,0);
    nextBoard=board;
    %Find where to put the next piece
    for up=1:size(nextBoard,1),
        if nextBoard(up,parentArray)~=0
            up=up-1;
            break;
        end
    end
    nextBoard(up,parentArray)=2;
  end
end
