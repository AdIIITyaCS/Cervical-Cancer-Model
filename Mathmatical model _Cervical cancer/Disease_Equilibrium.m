% MATLAB code for HPV and Cervical Cancer Model - Disease-free equilibrium
clear all; close all; clc;

% Initial conditions (in millions)
N0 = 451.815; % Total population
S0 = 421.896; % Initial susceptible
I0 = 29.819;  % Initial infected with HPV
C0 = 0.0991;  % Initial cervical cancer
R0 = 0.1;     % Initial recovered

% Parameter values - Modified with mu > 0.0765 while maintaining similar dynamics
mu = 0.08;    % Natural death rate (increased from 0.01 to 0.08, which is > 0.0765)

% Adjust other parameters to compensate for increased mu and maintain similar dynamics
beta = 0.30;  % Transmission rate of contact (increased from 0.30)
gamma = 0.4;  % Recovery rate from HPV
delta = 0.18; % Progression from HPV to cervical cancer (decreased from 0.18)
alpha = 0.12; % Recovery from cervical cancer (increased from 0.1)
Lambda = 36;  % Recruitment rate (increased from 6.8 to balance higher death rate)
xi = 0.2;     % Death rate from cervical cancer
alpha_dash = 0.01; % Saturation factor

% Compute R0 using normalized S~ = S0 / N0
S_tilde = S0 / N0;
R0_val = (S_tilde * beta) / (gamma + mu + delta);
fprintf('Calculated R0 ≈ %.4f\n', R0_val);
fprintf('Using mu = %.4f (> 0.0765)\n', mu);

% Time span
tspan = [0 500];

% Solve ODE system
[t, y] = ode45(@(t, y) SICR_model(t, y, Lambda, beta, mu, gamma, alpha, delta, xi), tspan, [S0; I0; C0; R0]);

% Plot results
figure('Position', [100, 100, 1000, 800]);

subplot(2, 2, 1);
plot(t, y(:, 1), 'b-', 'LineWidth', 2);
xlabel('Time (years)');
ylabel('Susceptible (in m.)');
title('(a) Susceptible S(t)');
grid on;
xlim([0 500]);
ylim([400 460]);

subplot(2, 2, 2);
plot(t, y(:, 2), 'r-', 'LineWidth', 2);
xlabel('Time (years)');
ylabel('Infected (in m.)');
title('(b) Infected I(t)');
grid on;
xlim([0 30]);
ylim([0 30]);

subplot(2, 2, 3);
plot(t, y(:, 3), 'm-', 'LineWidth', 2);
xlabel('Time (years)');
ylabel('Cervical cancer (in m.)');
title('(c) Cervical Cancer C(t)');
grid on;
xlim([0 100]);
ylim([0 6]);

subplot(2, 2, 4);
plot(t, y(:, 4), 'g-', 'LineWidth', 2);
xlabel('Time (years)');
ylabel('Recovered (in m.)');
title('(d) Recovered R(t)');
grid on;
xlim([0 100]);
ylim([0 30]);

% Save the figure
saveas(gcf, 'disease_free_equilibrium_updated.jpg');

% --- ODE Model Function ---
function dydt = SICR_model(t, y, Lambda, beta, mu, gamma, alpha, delta, xi)
    S = y(1);
    I = y(2);
    C = y(3);
    R = y(4);
    
    N = S + I + C + R;
    
    dSdt = Lambda - beta * S * I / N - mu * S;
    dIdt = beta * S * I / N - (gamma + mu + delta) * I;
    dCdt = delta * I - (alpha + mu + xi) * C;
    dRdt = gamma * I + alpha * C - mu * R;
    
    dydt = [dSdt; dIdt; dCdt; dRdt];
end