
%Sample simpply support beam single load and moment
%
%   /\ Ray                                  ||        /\ Rby
%   ||                                      ||F = 10  ||
%   ||                                      ||        ||
%   /o\-------------------------------------\/--------/o\
%  /   \                                             /   \                               
% --------                                          OOOOOOO
%    |--------------2m ----------------------|--.25m---|

%%
%setup
syms Ray F Rby;

forces_Y = Ray+Rby == F
moments_Y_at_a = Ray*0 - F*2 + Rby*2.25== 0;

%%solve reactions
F = 10

moments_Y_at_a = Ray*0 - F*2 + Rby*2.25== 0;

Rby = solve(moments_Y_at_a,Rby)
forces_Y = Ray+Rby == F;
Ray = solve(forces_Y,Ray)

%%
%singularity setup
reaction_A = Singularity_Term();
reaction_A.set_force(Ray,0);

force =  Singularity_Term();
force.set_force(-F,2);

reaction_B = Singularity_Term();
reaction_B.set_force(Rby,2.25);



%%
%singularity equation
full_equation = Singularity_Equation();
full_equation.add_term([reaction_A,force,reaction_B]);

%%
%see total
disp(full_equation)
%solve get total at x
disp(full_equation.sum_all_at_x(0))
disp(full_equation.sum_all_at_x(1))

%%
%plot
full_equation.plot_all(2.25);