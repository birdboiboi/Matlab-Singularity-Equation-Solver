classdef Singularity_Term < handle
    properties
        moment
        dist
        sheer
        slope
        displace
        
        dist_x
        moment_at_x
        displace_at_x
        sheer_at_x
        slope_at_x
        
    end
    methods
        function out = read_type(self)
            if polynomialDegree(self.moment) == -2
               out = "is Moment" 
            elseif polynomialDegree(self.moment) == -1
                out = "is Force"          
            elseif polynomialDegree(self.moment)== 0
                out = "is rectangle ditributed load"
            elseif   polynomialDegree(self.eqn) == 1
                out = "is Tri distributed load"
            end
        end
        
        function self = set_custom(self,F,dist,power)
            syms X;
            self.moment =  (1/factorial(power))*F * (X - dist).^(power);
            
            self.dist = dist;
            outs = self.integrate_eqn(self.moment,X,2);
            self.slope = outs(1);
            self.displace = outs(2);
            self.sheer = self.get_sheer();
        end
        function self = set_moment(self,F,dist)
            syms X;
            self.moment =  F * (X - dist).^(0);
            self.dist = dist;
            outs = self.integrate_eqn(self.moment,X,2);
            self.slope = outs(1);
            self.displace = outs(2);
            self.sheer = self.get_sheer();
        end
        function self = set_force(self,F,dist)
            syms X;
            self.moment =  F * (X - dist).^(1);
            self.dist = dist;
            outs = self.integrate_eqn(self.moment,X,2);
            self.slope = outs(1);
            self.displace = outs(2);
            self.sheer = self.get_sheer();
        end
        function set_rect_weight(self,F,dist)
            syms X;
            self.moment =  F/2 * (X - dist).^(2);
            self.dist = dist;
            outs = self.integrate_eqn(self.moment,X,2);
            self.slope = outs(1);
            self.displace = outs(2);
            self.sheer = self.get_sheer();
        end
        function set_tri_weight(F,dist)
            syms X;
            self.moment =  F/6 * (X - dist).^(3);
            self.dist = dist;
            outs = self.integrate_eqn(self.moment,X,2);
            self.slope = outs(1);
            self.displace = outs(2);
            self.sheer = self.get_sheer();
        end
       
        function out = integrate_eqn(self,eqn,x,timeFact)
            if  timeFact == 1
               out = [int(eqn)];
           else
               timeFact = timeFact - 1;
               out = [int(eqn);self.integrate_eqn(int(eqn),x,timeFact)];
           end
        end
        
        function self =  solve_at_x(self, dist_request)
        syms X
        % if dist = 1 and request = 0 return 0 bc (X-1) == (dist_request -
        % dist)
        self.dist_x = dist_request;
        self.dist_x
        self.dist
        if self.dist < self.dist_x
           self.sheer_at_x = subs(self.sheer,X,dist_request);
           self.moment_at_x = subs(self.moment,X,dist_request);
           self.slope_at_x = subs(self.slope,X,dist_request);
           self.displace_at_x = subs(self.displace,X,dist_request);        
        else
            self.sheer_at_x = 0;
            self.moment_at_x = 0;
            self.slope_at_x = 0;
            self.displace_at_x = 0;
        end
        
        
        end 
        
        function out = disp(self)
            
           syms Slope_ Shear_ Moment_ Displace_ Slope_at_X Shear_at_X Moment_at_X Displace_at_X;
           disp("singularity term");
           disp("----------");
           x_nothing = self.dist_x;
                  
         
           disp([Shear_; Moment_ ;Slope_; Displace_]== self.array_form());
           disp([ Shear_at_X; Moment_at_X ;Slope_at_X;Displace_at_X] ==self.array_form_at_x());
           
  
        end   
 
        function out= array_form(self)
            out = [self.sheer;self.moment;self.slope;self.displace];
            if isempty(out)
               out = [0;0;0;0];
            end
        end
        
        function out= array_form_at_x(self)
            out = [self.sheer_at_x;self.moment_at_x;self.slope_at_x;self.displace_at_x];
        if isempty(out)
               out = [0;0;0;0];
            end
        end
        
        function out = get_sheer(self) 
            out = diff(self.moment);
            if isempty(out)
                out = 0;
            end
        end
        function returned = plus(A,B)
           returned = Singularity_Term();
           returned.sheer = A.sheer + B.sheer;
           returned.moment = A.moment + B.moment;
           returned.slope = A.slope + B.slope;
           returned.displace = A.displace + B.displace;
           
           
           returned.sheer_at_x = A.sheer_at_x + B.sheer_at_x;
           returned.moment_at_x = A.moment_at_x + B.moment_at_x;
           returned.slope_at_x = A.slope_at_x + B.slope_at_x;
           returned.displace_at_x = A.displace_at_x + B.displace_at_x;
           
           
        end
        
        function returned = minus(A,B)
           returned = Singularity_Term();
           returned.sheer = A.sheer - B.sheer;
           returned.moment = A.moment - B.moment;
           returned.slope = A.slope - B.slope;
           returned.displace = A.displace - B.displace;
           
           
           returned.sheer_at_x = A.sheer_at_x - B.sheer_at_x;
           returned.moment_at_x = A.moment_at_x - B.moment_at_x;
           returned.slope = A.slope_at_x - B.slope_at_x;
           returned.displace = A.displace_at_x - B.displace_at_x;
        end
        
        function returned = eq(A,B)
           returned = Singularity_Term()
           returned.sheer = A.sheer == B.sheer;
           returned.moment = A.moment == B.moment;
           returned.slope = A.slope == B.slope;
           returned.displace = A.displace == B.displace;
           
           
           returned.sheer_at_x = A.sheer_at_x == B.sheer_at_x;
           returned.moment_at_x = A.moment_at_x == B.moment_at_x;
           returned.slope = A.slope_at_x == B.slope_at_x;
           returned.displace = A.displace_at_x == B.displace_at_x;
        end       
       
    end
end