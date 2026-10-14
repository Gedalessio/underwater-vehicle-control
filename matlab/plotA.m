close all
set(0, 'DefaultTextInterpreter', 'latex')
set(0, 'DefaultLegendInterpreter', 'latex')
set(0, 'DefaultAxesTickLabelInterpreter', 'latex')

% % % Percorso della cartella sul Desktop per salvataggio
% userDesktop = fullfile(getenv('USERPROFILE'), 'Desktop');  % Per Windows
% % userDesktop = fullfile(getenv('HOME'), 'Desktop');       % Per Linux/macOS
saveFolder = 'ControlACer';

% Crea la cartella se non esiste
if ~exist(saveFolder, 'dir')
    mkdir(saveFolder);
end

position_ = squeeze(out.position.Data);  % 6x120001

x = position_(1, :);
y = position_(2, :);
z = position_(3, :);
phi = position_(4, :);
theta = position_(5, :);
psi = position_(6, :);



xde = out.xdes.Data(:,1);
yde = out.xdes.Data(:,2);
zde = out.xdes.Data(:,3);
phide = out.xdes.Data(:,4);
thetade = out.xdes.Data(:,5);
pside = out.xdes.Data(:,6);

data = squeeze(out.error.Data);  % 6x120001

xytild = data(1, :);
yytild = data(2, :);
zytild = data(3, :);
phiytild = data(4, :);
thetaytild = data(5, :);
psiytild = data(6, :);

time_=out.xdes.Time;
time=out.xdes.Time;

tau_ = squeeze(out.tau.Data);  % 6x120001
timet=out.tau.Time;
tau1 = tau_(1, :)';
tau2 = tau_(2, :)';
tau3 = tau_(3, :)';
tau4 = tau_(4, :)';
tau5 = tau_(5, :);
tau6 = tau_(6, :);

% ni1 = out.ni.Data(:,1);
% ni2 = out.ni.Data(:,2);
% ni3= out.ni.Data(:,3);
% ni4 = out.ni.Data(:,4);
% ni5 = out.ni.Data(:,5);
% ni6 = out.ni.Data(:,6);
% 
% lambda_ = squeeze(out.lambda.Data);  % 6x120001
% 
% lambda1 = lambda_(1, :);
% lambda2 = lambda_(2, :);
% lambda3 = lambda_(3, :);
% lambda4 = lambda_(4, :);
% lambda5 = lambda_(5, :);
% lambda6 = lambda_(6, :);
% lambda7 = lambda_(7, :);
% lambda8 = lambda_(8, :);
% lambda9 = lambda_(9, :);







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




colors = parula(9); 
h1 = figure();
hold on
plot(xde, yde,'Color', colors(1,:), 'LineStyle', '--', 'LineWidth', lw, 'DisplayName', '$desired trajectory$')
plot(x, y,'Color', colors(5,:), 'LineWidth', lw, 'DisplayName', '$trajectory$')
legend('$desired trajectory$', '$trajectory$', 'Interpreter', 'latex')
xlabel('x[m]', 'FontSize', 10, 'Interpreter', 'latex')
ylabel('y[m]', 'FontSize', 10, 'Interpreter', 'latex')
title('Trajectory executed', 'FontSize', 10, 'Interpreter', 'latex')
legend('Location', 'best')
grid on
hold off
exportgraphics(h1, 'ControlACer/Traj.pdf', 'ContentType', 'vector')


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
exportgraphics(h7, 'ControlACer/position.pdf', 'ContentType', 'vector')

h3=figure();
set(h3, 'Position', [100, 100, 700, 525]);
subplot(2, 1, 1);  % Primo subplot (2 righe, 1 colonna, posizione 1)
hold on
plot(time_, xytild,'Color', colors(1,:), 'LineWidth', 1.2);
plot(time_,yytild,'Color', colors(7,:), 'LineWidth',1.2);
plot(time_,zytild,'Color', colors(3,:),'LineWidth',1.2);
ylabel('error position', 'FontSize', 10,'Interpreter','latex')
xlabel('t[s]', 'FontSize', 10,'Interpreter','latex')
legend('$e_x$','$e_y$', '$e_z$','Location', 'best', 'Interpreter','latex' )
title('Position Errors', 'FontSize', 10, 'Interpreter', 'latex')
% ylim([min(x_s)-0.02,max(x_s)+0.1]);
grid on

subplot(2, 1, 2);  % Secondo subplot (posizione 2)
hold on 
plot(time_, phiytild, 'Color', colors(1,:), 'LineWidth', 1.2);
plot(time_,thetaytild, 'Color', colors(7,:), 'LineWidth',1.2);
plot(time_,psiytild, 'Color', colors(3,:),'LineWidth',1.2);
ylabel('error orientation', 'FontSize', 10,'Interpreter','latex')
xlabel('t[s]', 'FontSize', 10,'Interpreter','latex')
legend({'$e_\phi$', '$e_\theta$', '$e_\psi$'}, ...
       'Location', 'best', ...
       'Interpreter', 'latex');
title('Orientation Errors', 'FontSize', 10, 'Interpreter', 'latex')
% ylim([min(x_s)-0.02,max(x_s)+0.1]);
grid on
exportgraphics(h3, 'ControlACer/errores.pdf', 'ContentType', 'vector')

h2=figure();
set(h2, 'Position', [100, 100, 700, 525]);
subplot(2, 1, 1);  % Primo subplot
hold on
plot(timet, tau1, 'Color', colors(1,:), 'LineWidth', 1.2);
plot(timet, tau2, 'Color', colors(7,:), 'LineWidth', 1.2);
plot(timet, tau3, 'Color', colors(3,:), 'LineWidth', 1.2);
ylabel('Force [N]', 'FontSize', 10, 'Interpreter','latex')
xlabel('t [s]', 'FontSize', 10, 'Interpreter','latex')
legend('$F_x$', '$F_y$', '$F_z$', 'Location', 'northwest', 'Interpreter','latex')
title('Force', 'FontSize', 10, 'Interpreter', 'latex')
grid on

% --- Inset zoom plot ---
% Intervallo da zoomare
zoom_range = [14 20];

% Crea un inset axes (posizione relativa: [left bottom width height])
inset = axes('Position', [0.65 0.65 0.25 0.25]);  % Cambia se serve
box on; hold on
plot(timet, tau1, 'Color', colors(1,:), 'LineWidth', 1.0);
plot(timet, tau2, 'Color', colors(7,:), 'LineWidth', 1.0);
plot(timet, tau3, 'Color', colors(3,:), 'LineWidth', 1.0);
xlim(zoom_range)
ylim([-30 30])
title('Zoom', 'FontSize', 8, 'Interpreter', 'latex')
set(gca, 'FontSize', 8)

% Aggiungi una cornice al riquadro (opzionale)
set(inset, 'Box', 'on');

subplot(2, 1, 2);  % Secondo subplot (posizione 2)
hold on 
plot(timet, tau4, 'Color', colors(1,:), 'LineWidth', 1.2);
plot(timet,tau5, 'Color', colors(7,:), 'LineWidth',1.2);
plot(timet,tau6, 'Color', colors(3,:),'LineWidth',1.2);
ylabel('Torque[Nm]', 'FontSize', 10,'Interpreter','latex')
xlabel('t[s]', 'FontSize', 10,'Interpreter','latex')
legend({'$T_\phi$', '$T_\theta$', '$T_\psi$'}, ...
       'Location', 'best', ...
       'Interpreter', 'latex');
title('Torque', 'FontSize', 10, 'Interpreter', 'latex')
% ylim([min(x_s)-0.02,max(x_s)+0.1]);
grid on
exportgraphics(h2, 'ControlACer/Tau.pdf', 'ContentType', 'vector')


% h4=figure();
% set(h4, 'Position', [100, 100, 700, 525]);
% subplot(2, 1, 1);  % Primo subplot (2 righe, 1 colonna, posizione 1)
% hold on
% plot(time, ni1, 'b', 'LineWidth', 1.2);
% plot(time,ni2, 'g', 'LineWidth',1.2);
% plot(time,ni3, 'c','LineWidth',1.2);
% ylabel('velocities[m/s]', 'FontSize', 10,'Interpreter','latex')
% xlabel('t[s]', 'FontSize', 10,'Interpreter','latex')
% legend('vel_x','vel_y', 'vel_z','Location', 'best', 'Interpreter','latex' )
% % ylim([min(x_s)-0.02,max(x_s)+0.1]);
% grid on
% 
% subplot(2, 1, 2);  % Secondo subplot (posizione 2)
% hold on 
% plot(time, ni4, 'b', 'LineWidth', 1.2);
% plot(time,ni5, 'g', 'LineWidth',1.2);
% plot(time,ni6, 'c','LineWidth',1.2);
% ylabel('omega[rad/s]', 'FontSize', 10,'Interpreter','latex')
% xlabel('t[s]', 'FontSize', 10,'Interpreter','latex')
% legend({'$w_\phi$', '$w_\theta$', '$w_\psi$'}, ...
%        'Location', 'best', ...
%        'Interpreter', 'latex');
% ylim([min(x_s)-0.02,max(x_s)+0.1]);
% grid on
% exportgraphics(h3, 'plotLinearandAlmost/R15errores.pdf', 'ContentType', 'vector')


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

% colors = lines(9);  % 9 colori distinti
% h5 = figure();
% hold on
% plot(time_, lambda1, 'Color', colors(1,:), 'LineWidth', 1, 'DisplayName', '$\lambda_1$')
% plot(time_, lambda2, 'Color', colors(2,:), 'LineWidth', 1, 'DisplayName', '$\lambda_2$')
% plot(time_, lambda3, 'Color', colors(3,:), 'LineWidth', 1, 'DisplayName', '$\lambda_3$')
% plot(time_, lambda4, 'Color', colors(4,:), 'LineWidth', 1, 'DisplayName', '$\lambda_4$')
% plot(time_, lambda5, 'Color', colors(5,:), 'LineWidth', 1, 'DisplayName', '$\lambda_5$')
% plot(time_, lambda6, 'Color', colors(6,:), 'LineWidth', 1, 'DisplayName', '$\lambda_6$')
% plot(time_, lambda7, 'Color', colors(7,:), 'LineWidth', 1, 'DisplayName', '$\lambda_7$')
% plot(time_, lambda8, 'Color', colors(8,:), 'LineWidth', 1, 'DisplayName', '$\lambda_8$')
% plot(time_, lambda9, 'Color', colors(9,:), 'LineWidth', 1, 'DisplayName', '$\lambda_9$')
% legend('$lambda_1$','$lambda_2$','$lambda_3$','$lambda_4$','$lambda_5$','$lambda_6$','$lambda_7$','$lambda_8$','$lambda_9$' , 'Interpreter', 'latex')
% xlabel('lambda', 'FontSize', 10, 'Interpreter', 'latex')
% ylabel('t[s]', 'FontSize', 10, 'Interpreter', 'latex')
% legend('Location', 'best')
% ylim([-120;300]);
% 
% grid on
% hold off