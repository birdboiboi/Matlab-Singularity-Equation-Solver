classdef Singularity_Term
    properties
        eqn
        dist
    end
    methods
        function out = read_type()
            if polynomialDegree(eqn) == -2
               out = "is Moment" 
            elseif polynomialDegree(eqn) == -1
                out = "is Force"          
            elseif polynomialDegree(eqn)== 0
                out = "is rectangle ditributed load"
            elseif   polynomialDegree(eqn) == 1
                out = "is Tri distributed load"
            end
        end
        function set_moment(F,dist)
            syms X
            eqn = F * (dist - X)^(-2)
        end
        function set_force(F,dist)
            syms X
            eqn = F * (dist - X)^(-1)
        end
        function set_rect_weight(F,dist)
            syms X
            eqn = F * (dist - X)^(0)
        end
        function set_tri_weight(T,dist)
           syms X
            eqn = T * (dist - X ) ^ 1 
        end
        
        function out = integrate_eqn(eqn,x,timeFact)
            if  timeFact == 1
               out = [integral(eqn,0,x)]
           else
               timeFact = timeFact - 1
               out = [integral(eqn,0,x);integrate_eqn(eqn,x,timeFact)]
           end
        end
        
        function sys_eqn_out =  get_eqn(integrate_factor, dist_request)
           if dist_requst > dist
            sys_eqn_out = integrate_eqn(eqn,dist_request-dist,4)
           else
            sys_eqn_out = [0;0;0;0]
           end
    end 
    end
end