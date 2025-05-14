% 
% t= 1/sqrt(3);
% 
% f=(2*t+2)^3 + 3*((2*t+2)^2) + (2*t+2);
% y = -(1/sqrt(3));
% f
% 
% g=(2*y+2)^3 + 3*((2*y+2)^2) + (2*y+2);
% g
% 
% ans = (f+g)*2;
% ans


% x=1/sqrt(3);
% y=-1/sqrt(3);
% 
% ans=sec((pi/4)*(x+1))+sec((pi/4)*(y+1));
% 
% ans/2

% x=sqrt(3/5);
% y=-sqrt(3/5);
% 
% ans = (8/9)*sec(pi/4) + (5/9)*(sec((pi/4)*(x+1))) + (5/9)*(sec((pi/4)*(y+1)));
% 
% ans/2

n=1;

x=1/sqrt(3);
y=1/sqrt(3);

ans=fun(x,y)+fun(-x,y)+ fun(x,-y) + fun(-x,-y);
ans



function f = fun(x,y)
    f=(x+3*y)^2;
end



