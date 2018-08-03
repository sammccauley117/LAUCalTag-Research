global GRID_SIZE;     GRID_SIZE     = 10;
global OBJECT_SIZE;   OBJECT_SIZE   = 1;
global TRAIN_SIZE;    TRAIN_SIZE    = 200000;
global TEST_SIZE;     TEST_SIZE     = 100;
global MOVE_DISTANCE; MOVE_DISTANCE = .1;
global ANGLE_STEP;    ANGLE_STEP    = 5;

% Train skills
turning = trainTurning()
moving  = trainMoving()

pause on;
while 1
    [robot, destination] = createObjects();
    deltaX = destination.x - robot.x;
    deltaY = destination.y - robot.y;
    angleR = robot.angle;
    angleB = calcAngleBetween(robot, destination);
    CW     = 1;
    CCW    = -1;
    
    moveF     = [deltaX deltaY angleR];
    turnF_CW  = [deltaX deltaY angleR angleB CW];
    turnF_CCW = [deltaX deltaY angleR angleB CCW];
    
    show(robot, destination);
    pause(1);
    
    count = 0;
    while calcDistanceBetween(robot, destination) > 1
        % Test Skills
        if predict(moving, moveF) == 1
            robot.move(MOVE_DISTANCE);
        end
        if predict(turning, turnF_CW) == 1
            robot.turnCW(ANGLE_STEP);
        elseif predict(turning, turnF_CCW) == 1
            robot.turnCCW(ANGLE_STEP);
        end
        
        % Update Variables
        deltaX = destination.x - robot.x;
        deltaY = destination.y - robot.y;
        angleR = robot.angle;
        angleB = calcAngleBetween(robot, destination);

        moveF     = [deltaX deltaY angleR];
        turnF_CW  = [deltaX deltaY angleR angleB CW];
        turnF_CCW = [deltaX deltaY angleR angleB CCW];
        show(robot, destination);
        pause(.01);
        
        count = count + 1;
        if count > 500
            break; 
        end
    end
        
    % while predict(moving, features) == 1 || predict(turning, turnF_CW == 1 || predict(turning, turnF_CCW) == 1
    %     robot.move(.1);
    %     features = [(destination.x - robot.x) (destination.y - robot.y) robot.angle];
    %     show(robot, destination);
    %     pause(.1);
    % end
end

function [model, trainTime] = trainMoving()
    % Variables
    global TRAIN_SIZE;
    global MOVE_DISTANCE;
    deltaX    = []; deltaY  = []; % destinationX - robotX | destinationY - robotY
    angleR    = []; label   = []; % Angle of robot        | label (good [1], bad [-1])

    tic; % Start timer
    for i = 1:TRAIN_SIZE
        [robot, destination] = createObjects();
        oAngleRobot   = robot.angle; % Original Robot pointing angle

        % Does moving the robot forward get it closer to the destination?
        preDistance  = calcDistanceBetween(robot, destination);
        robot.move(MOVE_DISTANCE);
        postDistance = calcDistanceBetween(robot, destination);
        L = -1;
        if(preDistance > postDistance)
            L = 1;
        end

        % Record data
        deltaX(i)      = destination.x - robot.x;
        deltaY(i)      = destination.y - robot.y;
        angleR(i)      = oAngleRobot;
        label(i)       = L; 

        % Show
        % trainData = table(deltaX', deltaY', angleR', angleB', direction', label');
        % trainData.Properties.VariableNames = {'deltaX' 'deltaY' 'angleR' 'angleB' 'direction' 'label'}
        % show(robot, destination);
        % w = waitforbuttonpress;
    end

    trainData = table(deltaX', deltaY', angleR', label');
    trainData.Properties.VariableNames = {'deltaX' 'deltaY' 'angleR' 'label'};

    % Train a model
    model = fitctree(trainData, 'label');
    trainTime = toc; % End timer
end

function [model, trainTime] = trainTurning()
    % Variables
    global TRAIN_SIZE;
    global ANGLE_STEP;
    deltaX    = []; deltaY  = [];
    angleR    = []; angleB  = [];
    direction = []; label   = [];

    tic; % Start timer
    for i = 1:2:TRAIN_SIZE
        [robot, destination] = createObjects();
        oAngleRobot   = robot.angle; % Original Robot pointing angle
        oAngleBetween = calcAngleBetween(robot, destination); % Original angle between Robot and Destination
        CW_Label  = 0;
        CCW_Label = 0;

        % CW Turn
        robot.turnCW(ANGLE_STEP);
        nAngleBetween = calcAngleBetween(robot, destination); % New angle between Robot and Destination
        if nAngleBetween < oAngleBetween
            CW_Label = 1;   % Turning CW makes the angle smaller--GOOD
        else
            CW_Label = -1;  % Turning CW makes the angle bigger--BAD
        end
        robot.setAngle(oAngleRobot); % Reset to original angle

        % CCW Turn
        robot.turnCCW(ANGLE_STEP);
        nAngleBetween = calcAngleBetween(robot, destination); % New angle between Robot and Destination
        if nAngleBetween < oAngleBetween
            CCW_Label = 1;  % Turning CCW makes the angle smaller--GOOD
        else
            CCW_Label = -1; % Turning CCW makes the angle bigger--BAD
        end
        robot.setAngle(oAngleRobot); % Reset to original angle

        % Record data
        deltaX(i)      = destination.x - robot.x;
        deltaX(i+1)    = destination.x - robot.x;
        deltaY(i)      = destination.y - robot.y;
        deltaY(i+1)    = destination.y - robot.y;
        angleR(i)      = oAngleRobot;
        angleR(i+1)    = oAngleRobot;
        angleB(i)      = oAngleBetween;
        angleB(i+1)    = oAngleBetween;
        direction(i)   = 1; 
        direction(i+1) = -1;
        label(i)       = CW_Label; 
        label(i+1)     = CCW_Label;

        % Show
        % trainData = table(deltaX', deltaY', angleR', angleB', direction', label');
        % trainData.Properties.VariableNames = {'deltaX' 'deltaY' 'angleR' 'angleB' 'direction' 'label'}
        % show(robot, destination);
        % w = waitforbuttonpress;
    end

    trainData = table(deltaX', deltaY', angleR', angleB', direction', label');
    trainData.Properties.VariableNames = {'deltaX' 'deltaY' 'angleR' 'angleB' 'direction' 'label'};

    % Train a model
    model = fitctree(trainData, 'label');
    trainTime = toc;
end


%{
numCorrect = 0;

for i = 1:TEST_SIZE
    i
    [robot, destination] = createObjects();
    show(robot, destination);
    pause(.01);
    
    a = calcAngleBetween(robot, destination);
    CW_Features  = [(destination.x-robot.x) (destination.y-robot.y) robot.angle a 1];
    CCW_Features = [(destination.x-robot.x) (destination.y-robot.y) robot.angle a -1];
    
    for moves = 1:1000
        if predict(model, CW_Features) == 1
            robot.turnCW();
        elseif predict(model, CCW_Features) == 1
            robot.turnCCW();
        else
            break;
        end
        a = calcAngleBetween(robot, destination);
        CW_Features  = [(destination.x-robot.x) (destination.y-robot.y) robot.angle a 1];
        CCW_Features = [(destination.x-robot.x) (destination.y-robot.y) robot.angle a -1];
        
        robot.move();
        
        show(robot, destination);
        pause(.01);
        
        %if calcAngleBetween(robot, destination) < 7.5
        %    numCorrect = numCorrect + 1;
        %    break;
        %end
    end
end

fprintf("Accuracy: %d\n", numCorrect / TEST_SIZE * 100);
%}









%{
% robotX       = []; robotY       = []; robotAngle = [];
% destinationX = []; destinationY = [];
% angleBetween = []; direction    = [];  
% label        = [];

tic;
for i = 1:2:TRAIN_SIZE
    [robot, destination] = createObjects();
    oAngleRobot   = robot.angle; % Original Robot pointing angle
    oAngleBetween = calcAngleBetween(robot, destination); % Original angle between Robot and Destination
    CW_Label  = 0;
    CCW_Label = 0;
    
    % CW Turn
    robot.turnCW();
    nAngleBetween = calcAngleBetween(robot, destination); % New angle between Robot and Destination
    if nAngleBetween < oAngleBetween
        CW_Label = 1;   % Turning CW makes the angle smaller--GOOD
    else
        CW_Label = -1;  % Turning CW makes the angle bigger--BAD
    end
    robot.setAngle(oAngleRobot); % Reset to original angle
    
    % CCW Turn
    robot.turnCCW();
    nAngleBetween = calcAngleBetween(robot, destination); % New angle between Robot and Destination
    if nAngleBetween < oAngleBetween
        CCW_Label = 1;  % Turning CCW makes the angle smaller--GOOD
    else
        CCW_Label = -1; % Turning CCW makes the angle bigger--BAD
    end
    robot.setAngle(oAngleRobot); % Reset to original angle
    
    % Record data
    robotX(i) = robot.x; robotX(i + 1) = robot.x;
    robotY(i) = robot.y; robotY(i + 1) = robot.y;
    robotAngle(i) = robot.angle; robotAngle(i + 1) = robot.angle;
    destinationX(i) = destination.x; destinationX(i + 1) = robot.x;
    destinationY(i) = destination.y; destinationY(i + 1) = destination.y;
    angleBetween(i) = oAngleBetween; angleBetween(i + 1) = oAngleBetween;
    direction(i) = 1; direction(i + 1) = -1; % CW = 1   CCW = -1
    label(i) = CW_Label; label(i + 1) = CCW_Label;
end

trainData = table(robotX', robotY', robotAngle', destinationX', destinationY', angleBetween', direction', label');
trainData.Properties.VariableNames = {'RobotX' 'RobotY' 'RobotAngle' 'DestinationX' 'DestinationY' 'angleBetween' 'Direction' 'Label'};

% Train a model
model = fitctree(trainData, 'Label');
fprintf("Train Time: %.2f", toc);
pause(3);

numCorrect = 0;

for i = 1:TEST_SIZE
    i
    [robot, destination] = createObjects();
    show(robot, destination);
    pause(.01);
    
    a = calcAngleBetween(robot, destination);
    CW_Features  = [robot.x robot.y robot.angle destination.x destination.y a 1];
    CCW_Features = [robot.x robot.y robot.angle destination.x destination.y a -1];
    
    for moves = 1:180
        if predict(model, CW_Features) == 1
            robot.turnCW();
        elseif predict(model, CCW_Features) == 1
            robot.turnCCW();
        else
            break;
        end
        a = calcAngleBetween(robot, destination);
        CW_Features  = [robot.x robot.y robot.angle destination.x destination.y a 1];
        CCW_Features = [robot.x robot.y robot.angle destination.x destination.y a -1];
        
        show(robot, destination);
        pause(.01);
        
        if calcAngleBetween(robot, destination) < 1
            numCorrect = numCorrect + 1;
            break;
        end
    end
end

fprintf("Accuracy: %d\n", numCorrect / TEST_SIZE * 100);
%}

function distance = calcDistanceBetween(robot, destination)
    distance = sqrt((robot.x-destination.x)^2+(robot.y-destination.y)^2);
end

% Returns how many degrees the robot needs to turn in order to be pointing
% at the destination
function angle = calcAngleBetween(robot, destination) 
    pVector = [(cosd(robot.angle)) (sind(robot.angle))];             % Vector of robot pointing direction
    bVector = [(destination.x - robot.x) (destination.y - robot.y)]; % Vector of robot to destination
    
    PdotB = (pVector(1) * bVector(1)) + (pVector(2) * bVector(2));
    pMag  = sqrt(pVector(1)^2 + pVector(2)^2);
    bMag  = sqrt(bVector(1)^2 + bVector(2)^2);
    angle = acosd(PdotB / (pMag * bMag));
    
    % Used to show vectors to verify
    % global GRID_SIZE;
    % clf;
    % axis([0 GRID_SIZE 0 GRID_SIZE]);
    % hold on;
    % plot([1 (pVector(1) + 1)], [1 (pVector(2) + 1)], 'r');
    % plot([1 (bVector(1) + 1)], [1 (bVector(2) + 1)], 'b');
    % hold off;
    % axis square;
end

% Plots Robot and Destination objects
function show(robot, destination)
    global GRID_SIZE;
    clf;
    axis([0 GRID_SIZE 0 GRID_SIZE]);
    axis square;
    destination.show();
    robot.show();
end

% Returns a Robot and a Destination object with random points and a random
% angle. Locations are at least OBJECT_SIZE apart
function [robot, destination] = createObjects()
    % Variables
    global GRID_SIZE;
    global OBJECT_SIZE;
    
    while true
        % Generate random coordinates
        robotX       = (rand * (GRID_SIZE - OBJECT_SIZE)) + (OBJECT_SIZE / 2);
        robotY       = (rand * (GRID_SIZE - OBJECT_SIZE)) + (OBJECT_SIZE / 2);
        destinationX = (rand * (GRID_SIZE - OBJECT_SIZE)) + (OBJECT_SIZE / 2);
        destinationY = (rand * (GRID_SIZE - OBJECT_SIZE)) + (OBJECT_SIZE / 2);
        
        % Check if they are at least further than OBJECT_SIZE apart
        if sqrt((robotX - destinationX)^2 + (robotY - destinationY)^2) > OBJECT_SIZE
            startingAngle = randi(360) - 1; % Create starting angle between 0-359 degrees
            robot = Robot([robotX robotY], startingAngle);
            destination = Destination([destinationX destinationY]);
            break;
        end
    end
end