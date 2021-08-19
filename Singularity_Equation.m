
classdef Singularity_Equation< handle
   properties
      term_list
      boundry_list
   end
   methods  
       function self = add_term(self,term)
          self.term_list = [self.term_list;term]
       end
       
       function self = set_boundry(seat_dist_x,value,stringPick)
          self_boundry_list = [boundry_dist;at_dist_x,value,stringPick]
       end
       
       function out = sum_all(self)
           total = self.term_list(1)
           total.solve_at_x(2) 
            for i = 2:3
                self.term_list(i).solve_at_x(2) ;
                total = total + self.term_list(i);
            end
           out = total;
       end
       
         function out = sum_all_at_x(self,x)
           total = self.term_list(1)
           total.solve_at_x(x) 
            for i = 2:length(self.term_list)
                self.term_list(i).solve_at_x(x) ;
                total = total + self.term_list(i);
            end
           out = total;
       end
       
       
   end
    
end
  