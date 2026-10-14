
% Parametri dell'ellisse (semiassi)
a = 0.6; b = 0.3; c = 0.3;

t=out.position.Time;
position_ = squeeze(out.position.Data);  % 6x120001

x = position_(1, :);
y = position_(2, :);
z = position_(3, :);
yaw = position_(4, :);
pitch = position_(5, :);
roll = position_(6, :);



% Crea ellissoide base centrata nell'origine
[xe, ye, ze] = ellipsoid(0, 0, 0, a, b, c, 30);

% Crea figura
figure('WindowState','maximized');
axis equal;
grid on;
xlabel('X'); ylabel('Y'); zlabel('Z');
view(3);

% Loop temporale
for i = 1:300:length(t)
    % Orientamento corrente
    Rz = [cos(yaw(i)) -sin(yaw(i)) 0;
          sin(yaw(i))  cos(yaw(i)) 0;
               0             0     1];
    Ry = [cos(pitch(i)) 0 sin(pitch(i));
                 0      1      0;
          -sin(pitch(i)) 0 cos(pitch(i))];
    Rx = [1     0             0;
          0 cos(roll(i)) -sin(roll(i));
          0 sin(roll(i))  cos(roll(i))];

    R = Rz * Ry * Rx;

    % Applica la rotazione all'ellissoide
    pts = [xe(:)'; ye(:)'; ze(:)'];
    rotated = R * pts;

    % Trasla l'ellissoide
    xr = reshape(rotated(1,:) + x(i), size(xe));
    yr = reshape(rotated(2,:) + y(i), size(ye));
    zr = reshape(rotated(3,:) + z(i), size(ze));

    % Pulisci e disegna
    clf;
    surf(xr, yr, zr, ...
    'FaceAlpha', 0.7, ...
    'EdgeColor', [0.4 0.4 0.4], ...  % contorno grigio chiaro
    'LineStyle', '-', ...
    'FaceColor', [0.3 0.7 1.0], ...  % azzurro chiaro
    'LineWidth', 0.3);
    hold on;
    plot3(x(1:i), y(1:i), z(1:i), 'k--', 'LineWidth', 1);
    axis equal;
    xlim([-11 11]); ylim([-5 5]); zlim([-1 2]);
    xlabel('X'); ylabel('Y'); zlabel('Z');
    title(sprintf('Time: %.2f s', t(i)));
    view(135, 30); % angolo visuale 3D
    grid on;
    pause(0.03);
end
