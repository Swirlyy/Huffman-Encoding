classdef myDict %pretty self explanatory, it's a class
    properties
        code
        symbol
    end
    methods
        function obj = set.code(obj,Value)
            obj.code=Value;
        end
        function obj =set.symbol(obj,Value)
            obj.symbol=Value;
        end
    end
end