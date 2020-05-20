classdef myNode < handle %handle makes it pass into methods by reference not by value.
                         %this actually helped a ton!
    properties
        symbol
        frequency
        parent
        code
        originalindex
    end
    methods
        function obj = set.symbol(obj,Value)
            obj.symbol = Value;
        end
        function obj = set.frequency(obj,Value)
            obj.frequency = Value;
        end
        function obj = set.parent(obj,Value)
            obj.parent = Value;
        end
        function obj = set.code(obj,Value)
            obj.code = Value;
        end
        function obj = set.originalindex(obj,Value)
            obj.originalindex = Value;
        end
    end
end