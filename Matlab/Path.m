% ************************************************** %
% Title:     Path.m                                  %
% Purpose:   Uses Machine Learning to create a model %
%            for basic path finding                  %
% Aurthor:   Sam McCauley                            %
% Professor: Dr. Daniel Lau                          %
% Date:      7/8/2018                                %
% ************************************************** %

% Global Variables
global BOARD_ROWS;  BOARD_ROWS  = 6;    % How many rows    are on the board
global BOARD_COLS;  BOARD_COLS  = 6;    % How many columns are on the board
global ROBOT;       ROBOT       = 1;    % Which number denotes the robot
global DESTINATION; DESTINATION = -1;   % Which number denotes the destination
global DATA_LEN;    DATA_LEN    = 100000; % How much data should be generated from generateData()

% Train Model
train();

function model = train()
    % Variables
    global DATA_LEN;
    global BOARD_ROWS;
    global BOARD_COLS;
    global ROBOT;
    global DESTINATION;
    valid = false; 
    [robotRows, robotCols, destRows, destCols, moves] = generateData();
    
    % Keep checking previous iterations until there is no "no move"
    while(~valid)
        % Check previous iterations
        numNoMoves = 0; % How many times "no move" appears in moves[]
        for i = 1:DATA_LEN
            if(rem(i, 100) == 0)
               fprintf("%d / %d\n", i, DATA_LEN); 
            end
            if(moves(i) == "no move")
                numNoMoves = numNoMoves + 1;
                % Count how many times each suggested move comes up
                % to pick the best
                % up    = 0; 
                % down  = 0;
                % left  = 0;
                % right = 0;
                for j = 1:DATA_LEN
                    
                    if(moves(j) ~= "no move")
                        if (robotRows(i) + 1 - destRows(i) == ...
                            robotRows(j)     - destRows(j) && ...
                            robotCols(i)     - destCols(i) == ...
                            robotCols(j)     - destCols(j))
                            moves(i) = "down";
                            break;
                        end
                        if (robotRows(i) - 1 - destRows(i) == ...
                            robotRows(j)     - destRows(j) && ...
                            robotCols(i)     - destCols(i) == ...
                            robotCols(j)     - destCols(j))
                            moves(i) = "up";
                            break;
                            % up = up + 1;
                        end
                        if (robotRows(i)     - destRows(i) == ...
                            robotRows(j)     - destRows(j) && ...
                            robotCols(i) + 1 - destCols(i) == ...
                            robotCols(j)     - destCols(j))
                            moves(i) = "right";
                            break;
                            % right = right + 1;
                        end
                        if (robotRows(i)     - destRows(i) == ...
                            robotRows(j)     - destRows(j) && ...
                            robotCols(i) - 1 - destCols(i) == ...
                            robotCols(j)     - destCols(j))
                            moves(i) = "left";
                            break;
                            % left = left + 1;
                        end
                    end
                end
               
                % Find most common suggested pattern
                % if (up >= down && up >= left && up >= right)
                %     moves(i) = "up";
                % end
                % if (down >= up && down >= left && down >= right)
                %     moves(i) = "down";
                % end
                % if (left >= up && left >= down && left >= right)
                %     moves(i) = "left";
                % end
                % if (right >= up && right >= down && right >= left)
                %     moves(i) = "right";
                % end
            end
        end
        fprintf("'No Moves' Left: %d\n", numNoMoves);
        valid = numNoMoves == 0;
    end
    
    % Now that every spot has a classification, we can train the model
    data = table(robotRows', robotCols', destRows', destCols', moves');
    data.Properties.VariableNames = {'RobotRow' 'RobotCol' 'DestRow' 'DestCol' 'Move'};
    model = fitcnb(data, 'Move');
    
    pause on;
    for i = 1:DATA_LEN
        if(moves(i) ~= "no move")
            valid = false;
            board = zeros(BOARD_ROWS, BOARD_COLS);
            board(robotRows(i), robotCols(i)) = ROBOT;
            board(destRows(i),  destCols(i))  = DESTINATION;
            showBoard(board);
            pause(.5);
            x = 0;
            while(~valid)
                [rr, rc, dr, dc] = findCoords(board);
                features = [rr, rc, dr, dc];
                m = predict(model, features);
                board = moveRobot(board, m);
                showBoard(board);
                pause(.5);
                x = x + 1;
                
                % Update Valid
                found = false;
                for row = (1:BOARD_ROWS)
                    for col = (1:BOARD_COLS)
                        if (board(row,col) == DESTINATION)
                            found = true;
                        end
                    end
                end
                valid = ~found;
                if x > 15
                    valid = true;
                end
            end
        end
    end
    
    
    
    %{

    % Train Initial Model
    [robotRows, robotCols, destRows, destCols, moves] = generateData();
    data = table(robotRows', robotCols', destRows', destCols', moves');
    data.Properties.VariableNames = {'RobotRow' 'RobotCol' 'DestRow' 'DestCol' 'Move'};
    model = fitcknn(data, 'Move');
    
    for iter = 2:MAX_ITER
        [robotRows, robotCols, destRows, destCols, moves] = generateData();
        cnt1 = 0;
        for i = 1:DATA_LEN
           if moves(i) == "no move"
              cnt1 = cnt1 + 1; 
           end
           % if moves(i) == "no move"
           %    cnt1 = cnt1 + 1;
           %    moves(i) = checkPreviousIter(model,robotRows(i),robotCols(i),destRows(i),destCols(i),BOARD_ROWS,BOARD_COLS);
           % end
        end
        
        % Check previous iterations
        moves = checkSurrounding(robotRows, robotCols, destRows, destCols, moves);
        
        % Check how many "no move"s there are after checkSurrounging
        cnt2 = 0;
        for i = 1:DATA_LEN
           if moves(i) == "no move"
              cnt2 = cnt2 + 1;
           end
        end
        
        fprintf("---------\niter: %d\ncnt1: %d\ncnt2: %d\n", iter, cnt1, cnt2);
        
        data = table(robotRows', robotCols', destRows', destCols', moves');
        data.Properties.VariableNames = {'RobotRow' 'RobotCol' 'DestRow' 'DestCol' 'Move'};
        model = fitcknn(data, 'Move');
        
        if cnt2 == 0
            pause on;
            for i = 1:DATA_LEN
                if(moves(i) ~= "no move")
                    valid = false;
                    board = zeros(BOARD_ROWS, BOARD_COLS);
                    board(robotRows(i), robotCols(i)) = ROBOT;
                    board(destRows(i),  destCols(i))  = DESTINATION;
                    showBoard(board);
                    pause(.5);
                    x = 0;
                    while(~valid)
                        [rr, rc, dr, dc] = findCoords(board);
                        features = [rr, rc, dr, dc];
                        m = predict(model, features);
                        board = moveRobot(board, m);
                        showBoard(board);
                        pause(.5);
                        x = x + 1;

                        % Update Valid
                        found = false;
                        for row = (1:BOARD_ROWS)
                            for col = (1:BOARD_COLS)
                                if (board(row,col) == DESTINATION)
                                  found = true;
                                end
                            end
                        end
                        valid = ~found;
                        if x > 15
                            valid = true; 
                        end
                    end
                end
            end
        end
    end 
    %}
end

function [robotRow, robotCol, destRow, destCol] = findCoords(board)
    % Variables
    global BOARD_ROWS;
    global BOARD_COLS;
    global ROBOT;
    global DESTINATION;
    
    % Get x,y for the robot and destination
    for row = (1:BOARD_ROWS)
       for col = (1:BOARD_COLS)
           if (board(row,col) == ROBOT)
               robotRow = row;
               robotCol = col;
           end
           if (board(row,col) == DESTINATION)
               destRow  = row;
               destCol  = col;
           end
       end
    end
end

function board = moveRobot(board, move)
    % Variables
    global BOARD_ROWS; 
    global BOARD_COLS;
    global ROBOT;
    [robotRow, robotCol, destRow, destCol] = findCoords(board);
    
    if(move == "up" && robotRow - 1 >= 1)
        board(robotRow, robotCol)     = 0;
        board(robotRow - 1, robotCol) = ROBOT;
    end
    if(move == "down" && robotRow + 1 <= BOARD_ROWS)
        board(robotRow, robotCol)     = 0;
        board(robotRow + 1, robotCol) = ROBOT;
    end
    if(move == "left" && robotCol - 1 >= 1)
        board(robotRow, robotCol)     = 0;
        board(robotRow, robotCol - 1) = ROBOT;
    end
    if(move == "right" && robotCol + 1 <= BOARD_COLS)
        board(robotRow, robotCol)     = 0;
        board(robotRow, robotCol + 1) = ROBOT;
    end
end

% Uses previous iterations of the model to update "no move"s 
function move = checkPreviousIter(model, robotRow, robotCol, destRow, destCol)
    % Variables
    global BOARD_ROWS;
    global BOARD_COLS;
    move = "no move"; % Default value
    
    if(robotRow + 1 <= BOARD_ROWS)
       features = [robotRow+1, robotCol, destRow, destCol];
       predictedMove = predict(model, features);
       if(predictedMove ~= "no move")
           move = predictedMove;
       end 
    end
    
    if(robotRow - 1 >= 1)
       features = [robotRow-1, robotCol, destRow, destCol];
       predictedMove = predict(model, features);
       if(predictedMove ~= "no move")
           move = predictedMove;
       end 
    end
    
    if(robotCol + 1 <= BOARD_COLS)
       features = [robotRow, robotCol+1, destRow, destCol];
       predictedMove = predict(model, features);
       if(predictedMove ~= "no move")
           move = predictedMove;
       end 
    end
    
    if(robotCol - 1 >= 1)
       features = [robotRow, robotCol-1, destRow, destCol];
       predictedMove = predict(model, features);
       if(predictedMove ~= "no move")
           move = predictedMove;
       end 
    end
end

% Generates training data (size set at global level)
function [robotRows, robotCols, destRows, destCols, classifications] = generateData()
    % Variables
    global ROBOT;
    global DESTINATION;
    global BOARD_ROWS; 
    global BOARD_COLS;
    global DATA_LEN;
    robotRows = [0]; robotCols = [0];
    destRows  = [0]; destCols  = [0];
    classStrings = [""];
    
    % Generate samples of data
    for i = 1:DATA_LEN
        board = zeros(BOARD_ROWS, BOARD_COLS);
        board = placeDot(board, ROBOT);
        board = placeDot(board, DESTINATION);
        [robotRow, robotCol, destRow, destCol, classification] = classifyMove(board);
        robotRows(i) = robotRow;
        robotCols(i) = robotCol;
        destRows(i)  = destRow;
        destCols(i)  = destCol;
        classStrings(i) = classification;
    end
    classifications = categorical(classStrings); % Convert classes to categorical datatype
end

% Labels training data
function [robotRow, robotCol, destRow, destCol, classification] = classifyMove(board)
    % Variables
    [robotRow, robotCol, destRow, destCol] = findCoords(board);
    classification = "no move"; % Default classification
    
    % Check possible moves
    if (robotRow == destRow)
        if (robotCol + 1 == destCol)
           classification = "right";
        end
        if (robotCol - 1 == destCol)
           classification = "left";
        end
    end
    if (robotCol == destCol)
        if (robotRow + 1 == destRow)
           classification = "down";
        end
        if (robotRow - 1 == destRow)
           classification = "up";
        end
    end
end

% Shows figure of a board
function showBoard(board)
    % Variables
    global BOARD_ROWS; 
    global BOARD_COLS;
    global ROBOT;
    global DESTINATION;
    CELL_SIZE = 1;
    
    clf % Clear previous figure
    
    % Draw Checker Board
    for row = (BOARD_ROWS:-1:1)
        for col = (1:BOARD_COLS)
            if rem(abs(row - col), 2) == 1
                rectangle('Position',[(col - 1)*CELL_SIZE (row - 1)*CELL_SIZE CELL_SIZE CELL_SIZE],...
                    'FaceColor',[0 0 0]);
            end
        end
    end
    
    % Draw Dots
    for row = (BOARD_ROWS:-1:1)
        for col = (1:BOARD_COLS)
            % Draw Green 'Robot' Dot
            if board(row, col) == ROBOT
                % fprintf("R:\t(%d,%d)\n",row,col);
                rectangle('Position',[((col - 1)*CELL_SIZE)+(CELL_SIZE/4)...
                    BOARD_ROWS-1-((row - 1)*CELL_SIZE)+(CELL_SIZE/4) CELL_SIZE/2 CELL_SIZE/2],...
                    'Curvature', [1 1], 'FaceColor',[0 1 0], 'EdgeColor', [0 1 0])
            end
            
            % Draw Red 'Destination' Dot
            if board(row, col) == DESTINATION
                % fprintf("D:\t(%d,%d)\n",row,col);
                rectangle('Position',[((col - 1)*CELL_SIZE)+(CELL_SIZE/4)...
                    BOARD_ROWS-1-((row - 1)*CELL_SIZE)+(CELL_SIZE/4) CELL_SIZE/2 CELL_SIZE/2],...
                    'Curvature', [1 1], 'FaceColor',[1 0 0], 'EdgeColor', [1 0 0])
            end
        end
    end
    
    axis equal; % Set aspect ration to 1:1
end

% Randomly places a number (num) on the board
function board = placeDot(board, num)
    [BOARD_ROWS, BOARD_COLS] = size(board); 
    valid = 0;
    while(valid == 0)
       m = randi([1, BOARD_ROWS]);
       n = randi([1, BOARD_COLS]);
       if board(m,n) == 0
          board(m,n) = num;
          valid = 1;
       end
    end
end