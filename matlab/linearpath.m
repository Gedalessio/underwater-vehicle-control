function [p_e,p_e_dot,p_e_dot_dot,s,sdot,s_T] = linearpath(pin, pf, ti, tf,si)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

p_in = pin(1:3);
p_fi = pf(1:3);
sf = si + norm(p_fi-p_in); %lunghezza tratto da percorrere
T = tf-ti; %tempo di percorrenza
Tc = 0.001;
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
sdotdot_c = sdot_c/tc;

%eq del moto
for i = 1:length(dt)-1
    if(dt(i)<tc) %TRATTO IN ACCELERAZIONE
        s(i) = si + 1/2*sdotdot_c*dt(i)^2;
        sdot(i) = sdotdot_c*dt(i);
        sdotdot(i) = sdotdot_c;
        elseif(dt(i)>=tc && dt(i)<T-tc) %TRATTO A VEL COSTANTE
            s(i) = si - 1/2*sdotdot_c*tc^2 + sdot_c*dt(i);
           % sdot(i) = sdotdot_c;
           sdot(i) = sdot_c;
            sdotdot(i) = 0;
            elseif(dt(i)>=T-tc) %TRATTO IN DECELERAZIONE
              s(i) = sf - 1/2*sdotdot_c*(dt(end)-dt(i))^2;
              sdot(i) = sdot_c+sdotdot_c*((T-tc)-dt(i));
              sdotdot(i) = -sdotdot_c;  
    end
end
p_e = p_in + (s-si)'*(p_fi-p_in)/(sf-si);

p_e_dot = sdot'*(p_fi-p_in)/(sf-si);
p_e_dot_dot = sdotdot'*(p_fi-p_in)/(sf-si); 
s_T=s(end);
end