# Matlab-Singularity-Equation-Solver
A very basic singularity solver for 2d beam equations


*Make sure matlab has the whole directory when running, any new script relies of Singularity_Term and Singularity_Equation*

Equations are made of terms where each turn is turned on and off appropriately

Singularity_Equation
   properties
      -term_list
      -boundry_list
      -sums
      -at_x
   methods  
      -add_term(self,term)
      -set_boundry(seat_dist_x,value,stringPick)
      -sum_all(self)
      -sum_all_at_x(self,x)
      -function out = disp(self)
      -function out=  plot_all(self,length,accuracy)   
      -function out = disp_at_x(self)
      
     
Singularity_Term 
    properties
        -moment
        -dist
        -sheer
        -slope
        -displace
        -dist_x
        -moment_at_x
        -displace_at_x
        -sheer_at_x
        -slope_at_x
    methods
        -read_type(self)       
        -set_custom(self,F,dist,power) 
        -set_moment(self,F,dist)  
        -set_force(self,F,dist)
        -set_rect_force(self,F,dist)
        -set_tri_force(F,dist)
        -integrate_eqn(self,eqn,x,timeFact)
        -disp(self)
        -array_form(self)
        -array_form_at_x(self)
        -plus(A,B)
        -minus(A,B)
        -eq(A,B)
          

  
