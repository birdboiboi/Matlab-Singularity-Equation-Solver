
classdef Singularity_Equation< handle
   properties
      term_list
      boundry_list
      sums
      at_x
   end
   methods  
       function self = add_term(self,term)
          self.term_list = [self.term_list;term]
       end
       
       function self = set_boundry(seat_dist_x,value,stringPick)
          self_boundry_list = [boundry_dist;at_dist_x,value,stringPick]
       end
       
       function out = sum_all(self)
           total = self.term_list(1);
           total.solve_at_x(2); 
            for i = 2:length(self.term_list);
                self.term_list(i).solve_at_x(2) ;
                total = total + self.term_list(i);
            end
           self.disp_at_x();
           fprintf("total value %s",total);
           out = [total.sheer;total.moment;total.slope;total.displace];
       end
       
         function out = sum_all_at_x(self,x)
           total = self.term_list(1);
           total.solve_at_x(x) ;
            for i = 2:length(self.term_list);
                self.term_list(i).solve_at_x(x) ;
                total = total + self.term_list(i);
            end
           out = [total.sheer_at_x;total.moment_at_x;total.slope_at_x;total.displace_at_x];
         end
       
         
        function out = disp(self)
           disp("singularity equation");
           disp("----------");
            A1 = ["Shear = "; "Moment = ";"Slope = "; "Displace = "];           
            for i = 1:length(self.term_list)
                A1 = A1 + ["+(";"+(";"+(";"+("] + self.term_list(i).array_form() + [")";")";")";")"];
            end
            fprintf('[%s]\n', A1 )
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
  