function [p_e,p_e_dot,p_e_dot_dot,s,sdot,s_T] = circularpath(pin, pf, ti, tf,si)
%UNTITLED2 Summary of this function goes here

p_in = pin(1:3);
p_fi = pf(1:3);
alpha= pin(6);

if (pin(7)==0)
    r = [0, 0, -1]; %asse circ per semplicità (non va bene se pi e pf non hanno stessa z)
%-1 ti fa fare i tratti circolari 'verso l'esterno'
else r = [0, 0, 1];
end

dir = p_fi-p_in;
dist = norm(p_fi-p_in);
middle_point = (p_in + p_fi)/2;
normal = cross(dir,r)/norm(cross(dir,r));

rho = dist/2/sin(alpha/2);

height = rho * cos(alpha/2);

c = middle_point + height*normal; %center position (row)

sf = si + rho*alpha; %lunghezza tratto da percorrere
T = tf-ti; %tempo di percorrenza
global Tc
dt = 0:Tc:T;

s = zeros(1,length(dt)-1);
sdot = zeros(1,length(dt)-1);
sdotdot = zeros(1,length(dt)-1);

sdot_c=1.5*abs(sf-si)/T; %scelta della velocità di crociera

%Il profilo è simmetrico rispetto sm = (si+sf)/2 e tm = tf/2 ->sdotdot è
%uguale sia in acc che in dece
%impongo la continuità  della velocità nel punto in cui cambio andamento
%(tc) + che la velcità raggiunta in quel punto sia pari a sdot_c
%ho 2 eq in 2 incognite: sdotdot_c e tc

tc = (sdot_c*T -(sf-si))/sdot_c;
%tc=1;
sdotdot_c = sdot_c/tc;

%eq del moto
for i = 1:length(dt)-1
    if(dt(i)<=tc) %TRATTO IN ACCELERAZIONE
        s(i) = si + 1/2*sdotdot_c*dt(i)^2;
        sdot(i) = sdotdot_c*dt(i);
        sdotdot(i) = sdotdot_c;
        elseif(dt(i)>tc && dt(i)<=T-tc) %TRATTO A VEL COSTANTE
            s(i) = si - 1/2*sdotdot_c*tc^2 + sdot_c*dt(i);
            sdot(i) = sdotdot_c;
            sdotdot(i) = 0;
            elseif(dt(i)>T-tc) %TRATTO IN DECELERAZIONE
              s(i) = sf - 1/2*sdotdot_c*(T-dt(i))^2;
              sdot(i) = sdot_c-sdotdot_c*(dt(i)-(T-tc));
              sdotdot(i) = -sdotdot_c;  
    end
end

p_e_rif = [rho*cos((s-si)'*1/rho), rho*sin((s-si)'*1/rho), zeros(length(dt)-1,1)];
p_e_dot_rif = sdot' .* [-sin((s-si)'*1/rho), cos((s-si)'*1/rho), zeros(length(dt)-1,1)];
p_e_dotdot_rif = (sdot.^2)' .* [-cos((s-si)'*1/rho)/rho, -sin((s-si)'*1/rho), zeros(length(dt)-1,1)] + sdotdot' .* [-sin((s-si)'*1/rho)/rho, cos((s-si)'*1/rho), zeros(length(dt)-1,1)];


 
 x_rif = ((p_in-c)/norm(p_in-c))';
 z_rif = r';
 y_rif = cross(x_rif, z_rif);
 R = [x_rif y_rif z_rif]; %rot matrix from circonference frame to base frame
 p_e = c + (R * p_e_rif')'; % ho bisogno di una info aggiuntiva (tipo asse circ) per determinare il centro dove sta
 p_e_dot = (R*p_e_dot_rif')';
 p_e_dot_dot = (R*p_e_dotdot_rif')';
 s_T=s(end);


end