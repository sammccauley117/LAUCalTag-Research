classdef Robot < handle
    properties
        % Constants
        ANGLE_STEP    = 1;   % How much a rotation changes the angle by
        SIZE          = 1;   % 1 graphical unit in size
        MOVE_DISTANCE = .01; % How many units a move forward is
        
        location = zeros(1,2); % x and y position
        x; y;                  % x and y position
%       xPointing; yPointing;  % x and y position of pointing direction
        angle;
    end
    
    methods
        % Constructor
        function obj = Robot(startingLocation, startingAngle)
            obj.location = startingLocation;
            obj.x        = startingLocation(1,1);
            obj.y        = startingLocation(1,2);
            obj.angle    = startingAngle;
        end
        
%         % Calculates where the end of the pointing arrow would be
%         function updatePointing(obj)
%             obj.xPointing = obj.SIZE * cosd(obj.angle) + obj.x;
%             obj.yPointing = obj.SIZE * sind(obj.angle) + obj.y;
%         end
        
        function show(obj)
            rectangle('Position',[(obj.x - obj.SIZE/2) (obj.y - obj.SIZE/2)...
                                  (obj.SIZE) (obj.SIZE)],...
                      'Curvature',1,...
                      'FaceColor',[.008 .541 .059],...
                      'EdgeColor',[.008 .541 .059]);
            x = obj.SIZE * cosd(obj.angle);
            y = obj.SIZE * sind(obj.angle);
            hold on; % Don't destroy graph
            plot([obj.x (obj.x + x)], [obj.y (obj.y + y)], 'r');
        end
        
        % function turnCW(obj)
        %     obj.angle = rem(obj.angle - obj.ANGLE_STEP, 360);
        % end
        %
        % function turnCCW(obj)
        %     obj.angle = rem(obj.angle + obj.ANGLE_STEP, 360);
        % end
        
        function turnCW(obj, degrees)
            obj.angle = rem(obj.angle - degrees, 360);
        end
        
        function turnCCW(obj, degrees)
            obj.angle = rem(obj.angle + degrees, 360);
        end
        
        function move(obj, distance)
            x = distance * cosd(obj.angle);
            y = distance * sind(obj.angle);
            obj.x = obj.x + x;
            obj.y = obj.y + y;
        end
        
        function setLocation(obj, x, y)
            obj.x = x;
            obj.y = y;
        end
        
        function setAngle(obj, angle)
            obj.angle = angle; 
        end
    end
end