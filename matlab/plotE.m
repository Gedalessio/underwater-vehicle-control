close all
set(0, 'DefaultTextInterpreter', 'latex')
set(0, 'DefaultLegendInterpreter', 'latex')
set(0, 'DefaultAxesTickLabelInterpreter', 'latex')

% % % Percorso della cartella sul Desktop per salvataggio
% userDesktop = fullfile(getenv('USERPROFILE'), 'Desktop');  % Per Windows
% % userDesktop = fullfile(getenv('HOME'), 'Desktop');       % Per Linux/macOS
saveFolder = 'ControlloEFermo';

% Crea la cartella se non esiste
if ~exist(saveFolder, 'dir')
    mkdir(saveFolder);
end
colors = lines(9);

x = out.position.Data(:,1);
y = out.position.Data(:,2);
z = out.position.Data(:,3);
phi = out.position.Data(:,4);
theta = out.position.Data(:,5);
psi = out.position.Data(:,6);


xde = out.xdes.Data(:,1);
yde = out.xdes.Data(:,2);
zde = out.xdes.Data(:,3);
phide = out.xdes.Data(:,4);
thetade = out.xdes.Data(:,5);
pside = out.xdes.Data(:,6);

data = squeeze(out.y_tilde.Data);  % 6x120001

xytild = data(1, :);
yytild = data(2, :);
zytild = data(3, :);
phiytild = data(4, :);
thetaytild = data(5, :);
psiytild = data(6, :);

time_=out.y_tilde.Time;

tau_ = squeeze(out.tau.Data);  % 6x120001

tau1 = tau_(1, :);
tau2 = tau_(2, :);
tau3 = tau_(3, :);
tau4 = tau_(4, :);
tau5 = tau_(5, :);
tau6 = tau_(6, :);
timet=out.tau.Time;

ni1 = out.ni.Data(:,1);
ni2 = out.ni.Data(:,2);
ni3= out.ni.Data(:,3);
ni4 = out.ni.Data(:,4);
ni5 = out.ni.Data(:,5);
ni6 = out.ni.Data(:,6);

lambda_ = squeeze(out.lambda.Data);  % 6x120001
timel=out.lambda.Time;

lambda1 = lambda_(1, :);
lambda2 = lambda_(2, :);
lambda3 = lambda_(3, :);
lambda4 = lambda_(4, :);
lambda5 = lambda_(5, :);
lambda6 = lambda_(6, :);
lambda7 = lambda_(7, :);
lambda8 = lambda_(8, :);
lambda9 = lambda_(9, :);







lw=1.4;
% h4 = figure();
% hold on
% plot(x_r, y_r, 'LineWidth', lw, 'Color', [0.2 0.2 0.8])               % omega(t)
% plot(t_finale, O_t_scalata, 'LineWidth', lw, 'Color', [0.8 0.2 0.2]) % omega(t) scalata
% plot(t_finale(indiceW), O_t_scalata(indiceW), 'x', ...
%   'MarkerSize', 10, 'LineWidth', 2, 'Color', 'r')
% legend('$\omega(t)$', '$\omega_{scaled}(t)$', sprintf('$\\omega_{scaled}(t)$ = %.2f rad/s', Thetasmax), 'Interpreter', 'latex')
% xlabel('$t$ [s]', 'Interpreter', 'latex')
% ylabel('$\omega$ [rad/s]', 'Interpreter', 'latex')
% grid on
% box on
% set(gca, 'FontSize', 10)
% set(gcf, 'Color', 'w')
% hold off
% exportgraphics(h4, 'plotsscaling/wscal.pdf', 'ContentType', 'vector')





h1 = figure();
hold on
plot(xde, yde, 'Color', colors(7,:), 'LineStyle', '--', 'LineWidth', lw, 'DisplayName', '$desired trajectory$')
plot(x, y,'Color', colors(8,:), 'LineWidth', lw, 'DisplayName', '$trajectory$')
legend('$desired trajectory$', '$trajectory$', 'Interpreter', 'latex')
title('Trajectory executed', 'FontSize', 10, 'Interpreter', 'latex')
xlabel('x[m]', 'FontSize', 10, 'Interpreter', 'latex')
ylabel('y[m]', 'FontSize', 10, 'Interpreter', 'latex')
legend('Location', 'best')
grid on
hold off
exportgraphics(h1, 'ControlloEFermo/Trajectory.pdf', 'ContentType', 'vector')


h7=figure();
set(h1, 'Position', [100, 100, 700, 525]);
subplot(2, 1, 1);  % Primo subplot (2 righe, 1 colonna, posizione 1)
hold on
plot(time_, x, 'Color', colors(1,:), 'LineWidth', 1.2);
plot(time_,y, 'Color', colors(6,:), 'LineWidth',1.2);
plot(time_,z, 'Color', colors(7,:),'LineWidth',1.2);
ylabel('position[m]', 'FontSize', 10,'Interpreter','latex')
xlabel('t[s]', 'FontSize', 10,'Interpreter','latex')
legend('X','Y', 'Z','Location', 'best', 'Interpreter','latex' )
title('Position', 'FontSize', 10, 'Interpreter', 'latex')
% ylim([min(x_s)-0.02,max(x_s)+0.1]);
grid on

subplot(2, 1, 2);  % Secondo subplot (posizione 2)
hold on 
plot(time_, phi,'Color', colors(1,:), 'LineWidth', 1.2);
plot(time_,theta,'Color', colors(6,:), 'LineWidth',1.2);
plot(time_,psi, 'Color', colors(7,:),'LineWidth',1.2);
ylabel('orientation[rad]', 'FontSize', 10,'Interpreter','latex')
xlabel('t[s]', 'FontSize', 10,'Interpreter','latex')
legend({'$\phi$', '$\theta$', '$\psi$'}, ...
       'Location', 'best', ...
       'Interpreter', 'latex');
% ylim([min(x_s)-0.02,max(x_s)+0.1]);
title('Orientation', 'FontSize', 10, 'Interpreter', 'latex')
grid on
exportgraphics(h7, 'ControlloEFermo/position.pdf', 'ContentType', 'vector')

h3=figure();
set(h3, 'Position', [100, 100, 700, 525]);
subplot(2, 1, 1);  % Primo subplot (2 righe, 1 colonna, posizione 1)
hold on
plot(time_, xytild, 'Color', colors(1,:), 'LineWidth', 1.2);
plot(time_,yytild, 'Color', colors(6,:), 'LineWidth',1.2);
plot(time_,zytild, 'Color', colors(7,:),'LineWidth',1.2);
ylabel('error position', 'FontSize', 10,'Interpreter','latex')
xlabel('t[s]', 'FontSize', 10,'Interpreter','latex')
legend('$e_x$','$e_y$', '$e_z$','Location', 'best', 'Interpreter','latex' )
title('Position Errors', 'FontSize', 10, 'Interpreter', 'latex')
% ylim([min(x_s)-0.02,max(x_s)+0.1]);
grid on

subplot(2, 1, 2);  % Secondo subplot (posizione 2)
hold on 
plot(time_, phiytild,'Color', colors(1,:), 'LineWidth', 1.2);
plot(time_,thetaytild,'Color', colors(6,:), 'LineWidth',1.2);
plot(time_,psiytild, 'Color', colors(7,:),'LineWidth',1.2);
ylabel('error orientation', 'FontSize', 10,'Interpreter','latex')
xlabel('t[s]', 'FontSize', 10,'Interpreter','latex')
legend({'$e_\phi$', '$e_\theta$', '$e_\psi$'}, ...
       'Location', 'best', ...
       'Interpreter', 'latex');
% ylim([min(x_s)-0.02,max(x_s)+0.1]);
title('Orientation Errors', 'FontSize', 10, 'Interpreter', 'latex')
grid on
exportgraphics(h3, 'ControlloEFermo/errores.pdf', 'ContentType', 'vector')

h2=figure();
set(h2, 'Position', [100, 100, 700, 525]);
subplot(2, 1, 1);  % Primo subplot (2 righe, 1 colonna, posizione 1)
hold on
plot(timet, tau1,'Color', colors(1,:), 'LineWidth', 1.2);
plot(timet,tau2, 'Color', colors(6,:), 'LineWidth',1.2);
plot(timet,tau3, 'Color', colors(7,:),'LineWidth',1.2);
ylabel('Force[N]', 'FontSize', 10,'Interpreter','latex')
xlabel('t[s]', 'FontSize', 10,'Interpreter','latex')
legend('$F_x$','$F_y$', '$F_z$','Location', 'best', 'Interpreter','latex' )
title('Force', 'FontSize', 10, 'Interpreter', 'latex')
% ylim([min(x_s)-0.02,max(x_s)+0.1]);
grid on

subplot(2, 1, 2);  % Secondo subplot (posizione 2)
hold on 
plot(timet, tau4, 'Color', colors(1,:), 'LineWidth', 1.2);
plot(timet,tau5, 'Color', colors(6,:), 'LineWidth',1.2);
plot(timet,tau6, 'Color', colors(7,:),'LineWidth',1.2);
ylabel('Torque[Nm]', 'FontSize', 10,'Interpreter','latex')
xlabel('t[s]', 'FontSize', 10,'Interpreter','latex')
legend({'$T_\phi$', '$T_\theta$', '$T_\psi$'}, ...
       'Location', 'best', ...
       'Interpreter', 'latex');
% ylim([min(x_s)-0.02,max(x_s)+0.1]);
title('Torque', 'FontSize', 10, 'Interpreter', 'latex')
grid on
exportgraphics(h2, 'ControlloEFermo/Tau.pdf', 'ContentType', 'vector')


h4=figure();
set(h4, 'Position', [100, 100, 700, 525]);
subplot(2, 1, 1);  % Primo subplot (2 righe, 1 colonna, posizione 1)
hold on
plot(time_, ni1, 'Color', colors(1,:), 'LineWidth', 1.2);
plot(time_,ni2,'Color', colors(6,:), 'LineWidth',1.2);
plot(time_,ni3,'Color', colors(7,:),'LineWidth',1.2);
ylabel('velocities[m/s]', 'FontSize', 10,'Interpreter','latex')
xlabel('t[s]', 'FontSize', 10,'Interpreter','latex')
legend('$v_x$','$v_y$', '$v_z$','Location', 'best', 'Interpreter','latex' )
title('velocities', 'FontSize', 10, 'Interpreter', 'latex')
% ylim([min(x_s)-0.02,max(x_s)+0.1]);
grid on

subplot(2, 1, 2);  % Secondo subplot (posizione 2)
hold on 
plot(time_, ni4, 'Color', colors(1,:), 'LineWidth', 1.2);
plot(time_,ni5,'Color', colors(6,:), 'LineWidth',1.2);
plot(time_,ni6, 'Color', colors(7,:),'LineWidth',1.2);
ylabel('omega[rad/s]', 'FontSize', 10,'Interpreter','latex')
xlabel('t[s]', 'FontSize', 10,'Interpreter','latex')
legend({'$w_\phi$', '$w_\theta$', '$w_\psi$'}, ...
       'Location', 'best', ...
       'Interpreter', 'latex');
title('omega', 'FontSize', 10, 'Interpreter', 'latex')
% ylim([min(x_s)-0.02,max(x_s)+0.1]);
grid on
exportgraphics(h4, 'ControlloEFermo/ni.pdf', 'ContentType', 'vector')
% 

% h2=figure();
% hold on
% plot(time, error_px, 'r', 'LineWidth', lw, 'DisplayName', '$e_{px}$')
% plot(time, error_py, 'b', 'LineWidth', lw, 'DisplayName', '$e_{py}$')
% plot(time, error_pz, 'g', 'LineWidth', lw, 'DisplayName', '$e_{pz}$')
% legend('$e_{px}$', '$e_{pv}$','$e_{pz}$', 'Interpreter', 'latex')
% xlabel('time', 'FontSize', 10, 'Interpreter', 'latex')
% ylabel('Error position', 'FontSize', 10, 'Interpreter', 'latex')
% legend('Location', 'best')
% grid on
% hold off
% exportgraphics(h2, 'Tiltingplot/erP.pdf', 'ContentType', 'vector')
% 
% h3=figure();
% hold on
% plot(time, error_Rd1, 'r', 'LineWidth', lw, 'DisplayName', '$e_{\omega,1}$')
% plot(time, error_Rd2, 'b', 'LineWidth', lw, 'DisplayName', '$e_{\omega,2}$')
% plot(time, error_Rd3, 'g', 'LineWidth', lw, 'DisplayName', '$e_{\omega,3}$')
% legend('$e_{R,1}$', '$e_{R,2}$','$e_{R,3}$', 'Interpreter', 'latex')
% xlabel('time', 'FontSize', 10, 'Interpreter', 'latex')
% ylabel('Error omega', 'FontSize', 10, 'Interpreter', 'latex')
% legend('Location', 'best')
% grid on
% hold off
% exportgraphics(h3, 'Tiltingplot/erW.pdf', 'ContentType', 'vector')
% 
% h4=figure();
% hold on
% plot(time, error_dpx, 'r', 'LineWidth', lw, 'DisplayName', '$e_{vx}$')
% plot(time, error_dpy, 'b', 'LineWidth', lw, 'DisplayName', '$e_{vy}$')
% plot(time, error_dpz, 'g', 'LineWidth', lw, 'DisplayName', '$e_{vz}$')
% legend('$e_{\omega,1}$', '$e_{\omega,2}$','$e_{\omega,2}$', 'Interpreter', 'latex')
% xlabel('time', 'FontSize', 10, 'Interpreter', 'latex')
% ylabel('Error velocity', 'FontSize', 10, 'Interpreter', 'latex')
% legend('Location', 'best')
% grid on
% hold off
% exportgraphics(h4, 'Tiltingplot/erV.pdf', 'ContentType', 'vector')

  % 9 colori distinti
h5 = figure();
hold on
plot(timel, lambda1, 'Color', colors(1,:), 'LineWidth', 1, 'DisplayName', '$\lambda_1$')
plot(timel, lambda2, 'Color', colors(2,:), 'LineWidth', 1, 'DisplayName', '$\lambda_2$')
plot(timel, lambda3, 'Color', colors(3,:), 'LineWidth', 1, 'DisplayName', '$\lambda_3$')
plot(timel, lambda4, 'Color', colors(4,:), 'LineWidth', 1, 'DisplayName', '$\lambda_4$')
plot(timel, lambda5, 'Color', colors(5,:), 'LineWidth', 1, 'DisplayName', '$\lambda_5$')
plot(timel, lambda6, 'Color', colors(6,:), 'LineWidth', 1, 'DisplayName', '$\lambda_6$')
plot(timel, lambda7, 'Color', colors(7,:), 'LineWidth', 1, 'DisplayName', '$\lambda_7$')
plot(timel, lambda8, 'Color', colors(8,:), 'LineWidth', 1, 'DisplayName', '$\lambda_8$')
plot(timel, lambda9, 'Color', colors(9,:), 'LineWidth', 1, 'DisplayName', '$\lambda_9$')
legend('$lambda_1$','$lambda_2$','$lambda_3$','$lambda_4$','$lambda_5$','$lambda_6$','$lambda_7$','$lambda_8$','$lambda_9$' , 'Interpreter', 'latex')
xlabel('t[s]', 'FontSize', 10, 'Interpreter', 'latex')
ylabel('lamda', 'FontSize', 10, 'Interpreter', 'latex')
legend('Location', 'best')
title('lambda', 'FontSize', 10, 'Interpreter', 'latex')
ylim([-100,150]);

grid on
hold off
exportgraphics(h5, 'ControlloEFermo/lambda.pdf', 'ContentType', 'vector')