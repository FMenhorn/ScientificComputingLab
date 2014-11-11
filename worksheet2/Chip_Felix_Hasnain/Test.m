%% Test AM Newton Function
% Show function behavior of G(x)
% --> one can see that G(x) has no roots for dt < 2/7
% --> for that, also see root derivation and eigenvalue relation computed 
%     analytically!
y = -20:0.5:20;
dt= 2/7;
y_const = 20;
G = @(y)(y-y_const-(dt/2)*(7*y_const-(7/10)*y_const^2+7.*y-(7/10)*y.^2));

plot(y,G(y),y,zeros(1,length(y)));


%% Test AML1
y = -20:0.5:20;
dt= 1/2;
y_const = 20;

G1 = @(y)(y-y_const-(dt/2)*(7*y_const-(7/10)*y_const^2+7.*y_const-(7/10)*y_const*y));
%plot(y,G1(y));

%% %% Test AML2

G2 = @(y)(y-y_const-(dt/2)*(7*y_const-(7/10)*y_const^2+7.*y-(7/10)*y_const*y));
%plot(y,G2(y));
