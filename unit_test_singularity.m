
a = Singularity_Term()

a
syms F
a.set_force(F,1)

a.moment
a.sheer
a.slope
a.displace

a.solve_at_x(2)
a.solve_at_x(1)
a.solve_at_x(0)

B = Singularity_Term()
B.set_moment(F,1)
B.moment
B.sheer
B.slope
B.displace

c = Singularity_Term()
c.set_custom(F,1,1)
%%
y = Singularity_Term();
y = a + B + c;
y.solve_at_x(2)
%z = y == a
%z.solve_at_x(0)

%%
lis = [Singularity_Term(),Singularity_Term(),Singularity_Term()]
lis(1).set_force(F,2)
lis(2).set_force(-F,1)
lis(3).set_force(5*F,1)

total = lis(1);
total.solve_at_x(2) 
for i = 2:3
    lis(i).solve_at_x(2) 
    lis(i)
    total = total + lis(i)
end
total

SE = Singularity_Equation()
SE.add_term(lis)
SE.sum_all()
SE.sum_all_at_x(10)
SE.sum_all_at_x(1889)