classdef Destination < handle
    properties
        location = zeros(1,2);
        x; y;
        size = 25; 
    end
    
    methods
        % Constructor
        function obj = Destination(startingLocation)
            obj.location = startingLocation;
            obj.x        = startingLocation(1,1);
            obj.y        = startingLocation(1,2);
        end
        
        function show(obj)
            rectangle('Position',[(obj.x - obj.size/2) (obj.y - obj.size/2)...
                                  (obj.size) (obj.size)],...
                      'Curvature',1,...
                      'FaceColor',[.930 .161 .224],...
                      'EdgeColor',[.930 .161 .224]);
        end     
    end
end