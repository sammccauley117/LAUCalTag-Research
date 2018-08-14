global WIDTH;     WIDTH     = 640;    % Width of environment (pixels)
global HEIGHT;    HEIGHT    = 480;    % Height of environment (pixels)
global TRAIN_LEN; TRAIN_LEN = 100000; % Ammount of train data
global CW;        CW        = 1;      % Classifier for CW rotation
global CCW;       CCW       = 0;      % Classifier for CCW rotation

% Train Model
moveSkill = trainMove()
turnSkill = trainTurn()


% Generate Destination
d = Destination([400, 400]);
r = Robot();

% Test
pause on
while 1
    r.update();
    f = [(d.x - r.x) (d.y - r.y) r.angle];
    
    if predict(moveSkill, f) == 1
        r.move(50);
    end
    
    for i = 1:50
        show(r, d);
        pause(1/200);
    end
end
show(r, d);

function model = trainTurn()
    % Variables
    global WIDTH;
    global HEIGHT;
    global TRAIN_LEN;
    global CW;
    global CCW;
    
    % Features and Label
    dx    = zeros(TRAIN_LEN, 1); % Delta X: (Destination X - Robot X)
    dy    = zeros(TRAIN_LEN, 1); % Delta Y: (Destination Y - Robot Y)
    ra    = zeros(TRAIN_LEN, 1); % Robot Angle 
    dir   = zeros(TRAIN_LEN, 1); % Turn Direction: 1 = CW, 0 = CCW
    label = zeros(TRAIN_LEN, 1); % Training Label: 1 = Good Move, 0 = Bad Move
    
    for i = 1:TRAIN_LEN
        % Generate Delta X and Delta Y
        while 1
            robotX = rand * WIDTH;
            robotY = rand * HEIGHT;
            destX  = rand * WIDTH;
            destY  = rand * HEIGHT;
            dx(i)  = destX - robotX;
            dy(i)  = destY - robotY;
            if dx(i) ~= 0 || dy(i) ~= 0 % Make sure they aren't at the same location
                break;
            end
        end
        
        % Generate random Robot Angle (0 - 360)
        ra(i) = rand * 360;
        
        % Pick a random direction to test
        dir(i) = int8(rand * 1);
        
        % Label turn
        angleBefore = angleBetween(dx(i), dy(i), ra(i)); % Angle between Robot to Destination and Robot's pointing angle before turning
        % Simulate turn
        if dir(i) == CW 
            raTurn = rem(ra(i) - .1, 360); % The robot's pointing angle after small CW turn
            angleAfter = angleBetween(dx(i), dy(i), raTurn);
        elseif dir(i) == CCW
            raTurn = rem(ra(i) + .1, 360); % The robot's pointing angle after small CW turn
            angleAfter = angleBetween(dx(i), dy(i), raTurn);
        end
        % Check if the turn reduced the angle between
        label(i) = angleBefore > angleAfter;
    end
    
    trainData = table(dx, dy, ra, dir, label);
    trainData.Properties.VariableNames = {'DeltaX' 'DeltaY' 'RobotAngle' 'Direction' 'Label'};
    model = fitctree(trainData, 'Label');
    
    % Uncomment to view data
    % for i = 1:TRAIN_LEN
    %     clf;
    %     axis([-640 640 -640 640]);
    %     hold on;
    %     plot([0 dx(i)], [0 dy(i)], 'r')
    %     plot([0 (100 * cosd(ra(i)))], [0 (100 * sind(ra(i)))], 'g');
    %     hold off;
    %     waitforbuttonpress;
    % end
end

function model = trainMove()
    % Variables
    global WIDTH;
    global HEIGHT;
    global TRAIN_LEN
    
    % Features and Label
    dx    = zeros(TRAIN_LEN, 1); % Delta X: (Destination X - Robot X)
    dy    = zeros(TRAIN_LEN, 1); % Delta Y: (Destination Y - Robot Y)
    ra    = zeros(TRAIN_LEN, 1); % Robot Angle 
    label = zeros(TRAIN_LEN, 1); % Training Label: 1 = Good Move, 0 = Bad Move
    
    for i = 1:TRAIN_LEN
        % Generate Delta X and Delta Y
        while 1
            robotX = rand * WIDTH;
            robotY = rand * HEIGHT;
            destX  = rand * WIDTH;
            destY  = rand * HEIGHT;
            dx(i)  = destX - robotX;
            dy(i)  = destY - robotY;
            if dx(i) ~= 0 || dy(i) ~= 0 % Make sure they aren't at the same location
                break;
            end
        end
        
        % Generate random Robot Angle (0 - 360)
        ra(i) = rand * 360;
        
        % Label move
        distanceBefore = sqrt(dx(i)^2+dy(i)^2); % The distance between the Robot and Dest. before/after moving
        distanceAfter  = sqrt((dx(i)-(.1 *cosd(ra(i))))^2+(dy(i)-(.1*sind(ra(i))))^2);
        label(i) = distanceBefore > distanceAfter;
    end
    
    trainData = table(dx, dy, ra, label);
    trainData.Properties.VariableNames = {'DeltaX' 'DeltaY' 'RobotAngle' 'Label'};
    model = fitctree(trainData, 'Label');
    
    % Uncomment to view data
    % for i = 1:TRAIN_LEN
    %     clf;
    %     axis([-640 640 -640 640]);
    %     hold on;
    %     plot([0 dx(i)], [0 dy(i)], 'r')
    %     plot([0 (100 * cosd(ra(i)))], [0 (100 * sind(ra(i)))], 'g');
    %     hold off;
    %     waitforbuttonpress;
    % end
end

function angle = angleBetween(dx, dy, ra)
    pVector = [(cosd(ra)) (sind(ra))]; % Vector of robot pointing direction
    bVector = [dx dy];                 % Vector of robot to destination
    
    PdotB = (pVector(1) * bVector(1)) + (pVector(2) * bVector(2));
    pMag  = sqrt(pVector(1)^2 + pVector(2)^2);
    bMag  = sqrt(bVector(1)^2 + bVector(2)^2);
    angle = acosd(PdotB / (pMag * bMag));
end

function show(r, d)
    % Set up grid
    clf;
    axis([0 640 0 640]);
    
    % Show Robot if it's valid
    if r.valid
        hold on;
        rectangle('Position',[(r.x - r.size/2) (r.y - r.size/2)...
                             (r.size) (r.size)],...
                  'Curvature',1,...
                  'FaceColor',[.008 .541 .059],...
                  'EdgeColor',[.008 .541 .059]);
        x = r.size * cosd(r.angle);
        y = r.size * sind(r.angle);
        plot([r.x (r.x + x)], [r.y (r.y + y)], 'r');
        hold off;
    end
    
    % Show destination
    d.show();
end
    








% r = Robot();
% SPEED = 50;
% MOVES = 5;
% FRAMES = 15;
% pause on;



% for i = 1:MOVES
%     r.update();
%     show(r);
%     r.move(SPEED);
% end
% 
% for i = 1:FRAMES
%     r.update();
%     show(r);
%     pause(1/FRAMES);
% end
% 
% for i = 1:MOVES
%     r.update();
%     show(r);
%     r.turnCW(SPEED);
% end
% 
% for i = 1:MOVES
%     r.update();
%     show(r);
%     r.turnCCW(SPEED);
% end
% 
% for i = 1:MOVES
%     r.update();
%     show(r);
%     r.turnCCW(SPEED);
% end
% 
% for i = 1:FRAMES
%     r.update();
%     show(r);
%     pause(1/FRAMES);
% end
% 
% for i = 1:MOVES
%     r.update();
%     show(r);
%     r.turnCW(SPEED);
% end
% 
% for i = 1:FRAMES
%     r.update();
%     show(r);
%     pause(1/FRAMES);
% end
% 
% for i = 1:10
%     r.update();
%     show(r);
%     r.move(-1 * SPEED);
% end
    
