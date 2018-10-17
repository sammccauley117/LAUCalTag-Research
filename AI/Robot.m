classdef Robot < handle
    properties
        % Constants
        ROBOT_FILE    = 'C:\Users\Sam\Documents\Git\UK-Research\LAUCalTagWidget\debug\robot.txt';
        WINDOW_WIDTH  = 640;
        WINDOW_HEIGHT = 480;
        COM_PORT      = 'COM5';
        BAUD_RATE     = 19200;
        DATA_BITS     = 8;
        STOP_BITS     = 1;
        MIN_PAUSE     = .25; % Minimum ammount of time between Serial Writes (to not overflow Arduino buffer) 
        SPEED_FACTOR  = .1;  % Forward movement speed is relatively arbitrary without a perspective of size

        x; y;       % (x, y) of origin of Robot
        dirX; dirY; % (x, y) of pointing direction
        angle;      % Pointing angle of Robot [0 - 360)
        size = 50;  % Estimate of the size of the robot
        serial;     % Serial Port connection
        valid = -1; % Whether or not instance of Robot is useable
    end
    
    methods
        % Constructor
        function obj = Robot(x, y, angle)
            obj.x = x;
            obj.y = y;
            obj.angle = angle; 
        end
        
%         function obj = Robot()
%             % Establish Serial Connection
%             instrreset; % Clear any existing connections
%             obj.serial = serial(obj.COM_PORT); % Create Serial Object
%             set(obj.serial,'BaudRate',obj.BAUD_RATE);
%             set(obj.serial,'DataBits',obj.DATA_BITS);
%             set(obj.serial,'StopBits',obj.STOP_BITS);
%             set(obj.serial,'Parity','none');
%             fopen(obj.serial);  % Open Serial
%             pause on; 
%             pause(2); % Wait ~2 seconds to wait for stable connection
%             tic; % Start write timer
%             
%             % Update robot environment variables
%             obj.update();
%         end
        
        % Write left and right commands to the motors
        function writeMotors(obj, left, right)
            % Make sure MIN_PAUSE has passed (to keep from overloading
            % Arduino's Serial buffer
            if obj.MIN_PAUSE > toc 
                pause(obj.MIN_PAUSE - toc); % Otherwise, wait until time has passed
            end
            
            % Write to the Serial buffer
            fwrite(obj.serial, uint8(left));
            fwrite(obj.serial, uint8(right));
            
            % Update tic value for next MIN_PAUSE calculation
            tic; 
        end
        
        % Turns the Robot clockwise at a given magnitude
        function turnCW(obj, magnitude)
             L = obj.toCommand('f', magnitude);
             R = obj.toCommand('b', magnitude);
             obj.writeMotors(L, R);
        end
        
        % Turns the Robot counter-clockwise at a given magnitude
        function turnCCW(obj, magnitude)
             L = obj.toCommand('b', magnitude);
             R = obj.toCommand('f', magnitude);
             obj.writeMotors(L, R);
        end
        
        % Moves the Robot forward a given magnitude (backwards if negative)
        function move(obj, magnitude)
            % Set direction
            forward = magnitude >= 0;
            
            % Check magnitude
            magnitude = abs(magnitude);
            if magnitude > 255
                magnitude = 255;
            end
            
            % Write
            if forward == 1
                L = obj.toCommand('f', magnitude);
                R = obj.toCommand('f', magnitude);
                obj.writeMotors(L, R);
            else
                L = obj.toCommand('b', magnitude);
                R = obj.toCommand('b', magnitude);
                obj.writeMotors(L, R);
            end
        end
        
        function moveMotors(obj, left, right, show)
            % Set up plot
            if show
                clf;
                axis([0 640 0 640]);
                axis square;
                hold on
                plot(obj.x, obj.y, 'r*');
            end
            
            % Special Cases
            if left == right
                obj.x = obj.x + (left * cosd(obj.angle));
                obj.y = obj.y + (left * sind(obj.angle));
            else
                if right > left
                    r = -1 * (left*obj.size) / (left - right);
                    theta = (57.29577951*left) / r;
                    turnCenterX = obj.x - ((obj.size/2) * cosd(obj.angle - 90)) - (r * cosd(obj.angle - 90));
                    turnCenterY = obj.y - ((obj.size/2) * sind(obj.angle - 90)) - (r * sind(obj.angle - 90));   
                    dx = (obj.x - turnCenterX) * cosd(-theta) + (obj.y - turnCenterY) * sind(-theta);
                    dy = (obj.x - turnCenterX) * sind(-theta) - (obj.y - turnCenterY) * cosd(-theta);
                    obj.x = turnCenterX + dx;
                    obj.y = turnCenterY - dy;
                    obj.angle = obj.angle + theta;
                    fprintf("INCORRECT\nturnCenterX: %f\nturnCenterY: %f\ndx: %f\ndy: %f\n", turnCenterX, turnCenterY, dx, dy);
                else 
                    r = -1 * (right*obj.size) / (right - left);
                    theta = (57.29577951*right) / r;
                    turnCenterX = obj.x + ((obj.size/2) * cosd(obj.angle - 90)) + (r * cosd(obj.angle - 90));
                    turnCenterY = obj.y + ((obj.size/2) * sind(obj.angle - 90)) + (r * sind(obj.angle - 90)); 
                    dx = (obj.x - turnCenterX) * cosd(-theta) - (obj.y - turnCenterY) * sind(-theta);
                    dy = (obj.x - turnCenterX) * sind(-theta) + (obj.y - turnCenterY) * cosd(-theta);
                    obj.x = turnCenterX + dx;
                    obj.y = turnCenterY + dy;
                    obj.angle = obj.angle - theta;
                    fprintf("CORRECT\nturnCenterX: %f\nturnCenterY: %f\ndx: %f\ndy: %f\n", turnCenterX, turnCenterY, dx, dy);
                end
                if show
                    obj.c(turnCenterX, turnCenterY, r, 'black');
                    obj.c(turnCenterX, turnCenterY, (r+obj.size), 'black');
                    obj.c(obj.x, obj.y, obj.size/2, 'blue');
                    obj.c(turnCenterX, turnCenterY, (r+(obj.size/2)), 'green');
                end
            end
            
            % Show Robot
            if show
                plot([obj.x (obj.x + obj.size * cosd(obj.angle))], [obj.y (obj.y + obj.size * sind(obj.angle))], 'r');
                hold off;
            end
        end
        
        % Circle
        function h = c(obj, x, y, r, color)
            d = r*2;
            px = x-r;
            py = y-r;
            h = rectangle('Position',[px py d d],'Curvature',[1,1],...
                'EdgeColor', color);
        end
        
        % Creates 8-bit control command to send to the Robot
        function cmd = toCommand(obj, direction, speed)
            upper = '0'; % Upper (MSB) is the direction bit
            % Check to make sure direction is a char array
            if ischar(direction) == 0
                error("Error in toCommand(obj, direction, speed): \n  [direction] must be an char array, not a(n) %s. \n  'f' = forwards, 'b' = backwards", class(direction));
            end
            
            % Select correct MSB based on direction
            if lower(direction) == 'f'
                upper = '0'; % 0 = forwards
            elseif lower(direction) == 'b'
                upper = '1'; % 1 = backwards
            end
            
            % Check to make sure speed is valid
            if speed > 255
                speed = 255;
            elseif speed < 0
                speed = 0;
            end
            
            % Build binary string
            lower_ = dec2bin(speed,7);
            cmdStr(1) = upper;
            for i = 1:7
                cmdStr(i + 1) = lower_(i);
            end
            
            % Convert binary string to uint8 command
            cmd = bin2dec(cmdStr);
        end
        
        % Reads and parses LAUCalTag's ROBOT_FILE to update realtime Robot variables 
        function update(obj)
            % Read ROBOT_FILE
            fileID = fopen(obj.ROBOT_FILE,'r');
            data   = fscanf(fileID, '%f');
            fclose(fileID);
            obj.valid = length(data) == 4;
            
            if obj.valid
                obj.x     = data(1);
                obj.dirX  = data(3);
                obj.y     = obj.WINDOW_HEIGHT - data(2);
                obj.dirY  = obj.WINDOW_HEIGHT - data(4);
            
                % Calculate the angle
                obj.angle = obj.calcAngle();

                % Calculate rough estimate of the Robot's relative size
                obj.size = sqrt((obj.dirX-obj.x)^2 + (obj.dirY-obj.y)^2) * 2;
            end
        end
        
        % Calculates the Robot's pointing angle (0 - 360)
        function angle = calcAngle(obj)
            zeroV    = [((obj.x + 100) - obj.x) 0];                 % Zero Degree Vector (flat line)
            angleV   = [(obj.dirX - obj.x) (obj.dirY - obj.y)];     % Angle Vector
            dot      = (zeroV(1)*angleV(1)) + (zeroV(2)*angleV(2)); % Dot Product of zeroV and angleV
            zeroMag  = sqrt(zeroV(1)^2 + zeroV(2)^2);               % Magnitude of zeroV            
            angleMag = sqrt(angleV(1)^2 + angleV(2)^2);             % Magnitude of angleV    
            a        = acosd(dot / (zeroMag * angleMag));           % Angle between the two vectors
            
            % Compensate for trigonometry
            if angleV(2) >= 0
                angle = a;
            else
                angle = 360 - a;
            end
        end
    end
end