
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

full_equation.E = 2000000
full_equation.I = 1.2 * 10 ^-6
%%
%see total
disp(full_equation)
%solve get total at x
full_equation.sum_all_at_x(0)
full_equation.sum_all_at_x(1)
%%
%solve constants

full_equation.add_boundry(3,0,"displacement")
%full_equation.add_boundry(0,0,"displacement")

full_equation.solve_constants()
%%
%plot
full_equation.plot_all(2.25);