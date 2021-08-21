# Matlab-Singularity-Equation-Solver
<p>
A very basic singularity solver for 2d beam equations<br>
*Make sure matlab has the whole directory when running, any new script relies of Singularity_Term and Singularity_Equation*<br>
Equations are made of terms where each turn is turned on and off appropriately<br>
   %Sample simpply support beam single load and moment
%<br>
</p>

 





<h2>Singularity_Equation</h2>
<ol>
   <li>properties</li>
   <ol>
      <li>term_list</li>
      <li>boundry_list</li>
      <li>sums</li>
      <li>at_x</li>
      </ol>
   methods  </li>
      <ol>
      <li>add_term(self,term)</li>
      <li>set_boundry(seat_dist_x,value,stringPick)</li>
      <li>sum_all(self)</li>
      <li>sum_all_at_x(self,x)</li>
      <li>disp(self)</li>
      <li>plot_all(self,length,accuracy) </li> 
      <li>disp_at_x(self)</li>
      </ol>
   </ol>
      
     
<h2>Singularity_Term</h2>
<ol>
    <li>properties</li>
   <ol>
        <li>moment</li>
        <li>dist</li>
        <li>sheer</li>
        <li>slope</li>
        <li>displace</li>
        <li>dist_x</li>
        <li>moment_at_x</li>
        <li>displace_at_x</li>
        <li>sheer_at_x</li>
        <li>slope_at_x</li>
      </ol>
    <li>methods<li>
      <ol>
        <li>read_type(self) </li>   
        <li>set_custom(self,F,dist,power) </li>
        <li>set_moment(self,F,dist)  </li>
        <li>set_force(self,F,dist)</li>
        <li>set_rect_force(self,F,dist)</li>
        <li>set_tri_force(F,dist)</li>
        <li>integrate_eqn(self,eqn,x,timeFact)</li>
        <li>disp(self)</li>
        <li>array_form(self)</li>
        <li>array_form_at_x(self)</li>
        <li>plus(A,B)</li>
        <li>minus(A,B)</li>
        <li>eq(A,B)</li>
         </ol>
       </ol>

  
