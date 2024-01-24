function [ fitness,est_alpha] = ...
CostFunc( x,F_rgb,B_rgb,U_rgb)
%COSTFUNC Fitness function of alpha matting

    x = round(x);
    x_F = x(:,1); x_B = x(:,2);
    
    Fx_rgb = F_rgb(x_F,:);
    Bx_rgb = B_rgb(x_B,:);

    % Alpah
    Fx_Bx_rgb = Fx_rgb - Bx_rgb;
    est_alpha = sum((U_rgb - Bx_rgb).*Fx_Bx_rgb,2)./(sum(Fx_Bx_rgb.*Fx_Bx_rgb,2)+1);
    est_alpha(est_alpha>1) = 1;
    est_alpha(est_alpha<0) = 0;
    % Chromatic distortion
    fitness  = norm2(U_rgb-(est_alpha.*Fx_rgb+(1-est_alpha).*Bx_rgb));

end

