%written by Jordan Irgang
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
            syms x;
            self.moment =  (1/factorial(power))*F * (x - dist).^(power);
            
            self.dist = dist;
            outs = self.integrate_eqn(self.moment,x,2);
            self.slope = outs(1);
            self.displace = outs(2);
            self.sheer = self.get_sheer();
        end
        function self = set_moment(self,F,dist)
            syms x;
            self.moment =  F * (x - dist).^(0);
            self.dist = dist;
            outs = self.integrate_eqn(self.moment,x,2);
            self.slope = outs(1);
            self.displace = outs(2);
            self.sheer = self.get_sheer();
        end
        function self = set_force(self,F,dist)
            syms x;
            self.moment =  F * (x - dist).^(1);
            self.dist = dist;
            outs = self.integrate_eqn(self.moment,x,2);
            self.slope = outs(1);
            self.displace = outs(2);
            self.sheer = self.get_sheer();
        end
        
        function set_rect_force(self,F,dist)
            syms x;
            self.moment =  F/2 * (x - dist).^(2);
            self.dist = dist;
            outs = self.integrate_eqn(self.moment,x,2);
            self.slope = outs(1);
            self.displace = outs(2);
            self.sheer = self.get_sheer();
        end
        
        function set_tri_force(F,dist)
            syms x;
            self.moment =  F/6 * (x - dist).^(3);
            self.dist = dist;
            outs = self.integrate_eqn(self.moment,x,2);
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
        syms x;
        % if dist = 1 and request = 0 return 0 bc (x-1) == (dist_request -
        % dist)
        self.dist_x = dist_request;
        
        if self.dist < self.dist_x
           self.sheer_at_x = subs(self.sheer,x,dist_request);
           self.moment_at_x = subs(self.moment,x,dist_request);
           self.slope_at_x = subs(self.slope,x,dist_request);
           self.displace_at_x = subs(self.displace,x,dist_request);        
        else
            self.sheer_at_x = 0;
            self.moment_at_x = 0;
            self.slope_at_x = 0;
            self.displace_at_x = 0;
        end
        
        
        end 
        
        function out = disp(self)
            
           syms Slope_ Shear_ Moment_ Displace_ Slope_at_x Shear_at_x Moment_at_x Displace_at_x;
           disp("singularity term");
           disp("----------");
           disp("@x = " + convertCharsToStrings(char(self.dist_x)));
           
           

            A1 = ["Shear = "; "Moment = ";"Slope = "; "Displace = "] + self.array_form();
            A2 = [ "    Shear_at_x = "; "    Moment_at_x = " ;"    Slope_at_x = ";"    Displace_at_x = "] + self.array_form_at_x();
            fprintf('[%s]\n', [A1+  A2] );
            
           
  
        end   
 
        function out= array_form(self)
            out = [convertCharsToStrings(char(self.sheer));
                convertCharsToStrings(char(self.moment));
                convertCharsToStrings(char(self.slope));
                convertCharsToStrings(char(self.displace))];
            
            if out == ["";"";"";""]
               out = ["0";"0";"0";"0"];
            end
        end
        
        function out= array_form_at_x(self)
            
            out = [convertCharsToStrings(char(self.sheer_at_x));
                convertCharsToStrings(char(self.moment_at_x));
                convertCharsToStrings(char(self.slope_at_x));
                convertCharsToStrings(char(self.displace_at_x))];
            
            if out == ["";"";"";""]
               out = ["0";"0";"0";"0"];
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
           returned = Singularity_Term();
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