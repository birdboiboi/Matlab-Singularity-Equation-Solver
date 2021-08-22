
classdef Singularity_Equation< handle
   properties
      term_list
      boundry_list
      sums
      at_x
      E
      I
      
      theta
      y
      C1
      C2
   end
   methods  
       
       function self = Singularity_Equation(self)
           syms C1 C2 E I y theta;
           
           self.C1 = C1;
           self.C2 = C2;
           self.E = E;
           self.I = I;
           self.theta = theta;
           self.E = E;
       end
       
       function self = add_term(self,term)
          self.term_list = [self.term_list;term]
       end
       
       function self = add_boundry(self,at_dist_x,value,string_pick)
           switch string_pick
               case "sheer"
                   eqn_type = 1
               case "moment"
                   eqn_type = 2
               case "slope"
                   eqn_type = 3
               case "displacement"
                   eqn_type = 4
           end
                
          self.boundry_list = [self.boundry_list;at_dist_x,value,eqn_type]
       end
       
       function out = sum_all(self)
           total = self.term_list(1); 
            for i = 2:length(self.term_list);
                self.term_list(i).solve_at_x(2) ;
                total = total + self.term_list(i);
            end
           self.disp_at_x();
           fprintf("total value %s",total);
           syms x
           out = [total.sheer ;total.moment;total.slope + self.C1;total.displace+self.C1*x + self.C2];
       end
       
         function out = sum_all_at_x(self,x)
           total = self.term_list(1);
           total.solve_at_x(x) ;
            for i = 2:length(self.term_list);
                self.term_list(i).solve_at_x(x) ;
                total = total + self.term_list(i);
            end
           total.sheer_at_x
           
           out = [total.sheer_at_x;total.moment_at_x;(total.slope_at_x + self.C1)/(self.I*self.E);(total.displace_at_x+self.C1*x+self.C2)/(self.I * self.E)]
         end
       
         
        function out = disp(self)
           disp("singularity equation");
           disp("----------");
            A1 = ["Shear = "; "Moment = ";"Slope = "; "Displace = "];           
            for i = 1:length(self.term_list)
                A1 = A1 + ["+(";"+(";"+(";"+("] + self.term_list(i).array_form() + [")";")";")";")"];
            end
            %+C1*X + C2 == EI*y
            %C1 == EI*theta
            fprintf('[%s]\n', A1 )
        end   
       
        function out = solve_constants(self)
               eqns = []
               %need to vectorize for better performance
               for i = 1: size(self.boundry_list,1)
                   %self.list_boundries(1) = x value
                   %self.list_boundries(2) = final value
                   %self.list_boundries(3) =(sheer = 1,moment = 2,slope =3,
                   %displace = 4)
                   disp(i)
                   eqn = self.sum_all_at_x(self.boundry_list(i,1)) == self.boundry_list(i,2);
                   eqns(i) = eqn(self.boundry_list(i,3));
                   
                   
               end
               
               self.C1 = solve(eqns,self.C1)
               self.C2 = solve(eqns,self.C2)
                             
        end
        
        function out=  plot_all(self,length,accuracy)
           
           switch nargin
               case 2
                   accuracy = 0.0125
           end
            x = [accuracy:accuracy:length];
            total_range = self.sum_all_at_x(0)

            for i = x;
                total_range = [total_range,self.sum_all_at_x(i)];
            end;

            x = [0:accuracy:length];
            total_range;
            total_range= double(total_range);

            figure()
            subplot(2,2,1)
            plot(x,total_range(1,:))
            title("sheer")
            subplot(2,2,2)
            plot(x,total_range(2,:))
            title("moment")
            subplot(2,2,3)
            plot(x,total_range(3,:))
            title("slope")
            subplot(2,2,4)
            plot(x,total_range(4,:))
            title("displace")
            out = total_range
        end
        
        function out = disp_at_x(self)
           disp("singularity equation");
           disp("----------");
            A1 = ["Shear = "; "Moment = ";"Slope = "; "Displace = "];           
            for i = 1:length(self.term_list)
                A1 = A1 + ["+(";"+(";"+(";"+("] + self.term_list(i).array_form_at_x() + [")";")";")";")"];
            end
            fprintf('[%s]\n', A1 )
        end   
       
  
    
   end

end
  