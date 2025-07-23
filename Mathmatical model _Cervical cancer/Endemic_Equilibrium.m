% HPV Endemic Equilibrium Model - Smoothed Oscillation Version
% Goal: Reduce sharp peaks and deep drops in Infected graph

clear all;
close all;

% Time span for simulation (in years)
tspan = [0 500];

% Initial conditions (in millions)
S0 = 421.896;  % Susceptible
N0 = 451.815;  % Total population
I0 = 29.819;   % Infected with HPV
C0 = 0.0991;   % Cervical cancer
R0 = 0;        % Recovered
initial = [S0; I0; C0; R0];

% Parameters (adjusted for stability)
Lambda = 8.8;      % Recruitment rate (births)
beta = 0.41;       % Infection rate (reduced slightly)
gamma = 0.2;       % Recovery rate (increased)
mu = 0.012;        % Natural death rate
alpha = 0.012;     % HPV to cancer progression
delta = 0.008;     % Cancer death rate
xi = 0.001;        % Cancer recovery rate (renamed from rho)

% Calculated Alpha Prime for equilibrium formula
alpha_prime = alpha / (xi + delta + mu);

% Basic Reproduction Number
%Ro = beta / (gamma + mu+ gamma);

S_tilde = S0 / N0;
Ro = (S_tilde * beta) / (gamma + mu + delta);
fprintf('Calculated R0 ≈ %.4f\n', Ro);

fprintf('Initial Conditions:\nS0 = %.3f million\nI0 = %.3f million\nC0 = %.4f million\nR0 = %.1f million\n\n', ...
        S0, I0, C0, R0);
fprintf('Adjusted Basic Reproduction Number (Ro): %.4f\n', Ro);
fprintf('Alpha Prime (α''): %.4f\n', alpha_prime);

% Solve ODE system
[t, y] = ode45(@(t,y) hpvModel(t, y, Lambda, beta, gamma, mu, alpha, delta, xi), tspan, initial);

% Create figure with adjusted size and font
figure('Units', 'normalized', 'OuterPosition', [0.1 0.1 0.8 0.8]);

% (a) Susceptible
subplot(2, 2, 1);
plot(t, y(:,1), 'LineWidth', 2, 'Color', 'blue');
title('(a) Susceptible S(t)', 'FontSize', 12);
xlabel('Time (years)', 'FontSize', 10);
ylabel('Susceptible population (in million)', 'FontSize', 10);
ylim([150 500]);
xlim([0 500]);
grid on;

% (b) Infected
subplot(2, 2, 2);
plot(t, y(:,2), 'LineWidth', 2, 'Color', 'red');
title('(b) Infected with HPV I(t)', 'FontSize', 12);
xlabel('Time (years)', 'FontSize', 10);
ylabel('Infected with HPV population (in million)', 'FontSize', 10);
ylim([0 80]);
xlim([0 500]);
grid on;

% (c) Cervical cancer
subplot(2, 2, 3);
plot(t, y(:,3), 'LineWidth', 2, 'Color', 'magenta');
title('(c) Cervical cancer C(t)', 'FontSize', 12);
xlabel('Time (years)', 'FontSize', 10);
ylabel('Cervical cancer population (in million)', 'FontSize', 10);
ylim([0 20]);
xlim([0 500]);
grid on;

% (d) Recovered
subplot(2, 2, 4);
plot(t, y(:,4), 'LineWidth', 2, 'Color', 'green');
title('(d) Recovered R(t)', 'FontSize', 12);
xlabel('Time (years)', 'FontSize', 10);
ylabel('Recovered population (in million)', 'FontSize', 10);
ylim([0 350]);
xlim([0 500]);
grid on;

% Main Title
sgtitle(sprintf('Endemic Equilibrium (Ro = %.4f)', Ro), 'FontSize', 14, 'FontWeight', 'bold');

% Save figure
saveas(gcf, 'hpv_endemic_equilibrium_smooth.png');

% --- ODE Function for HPV Model ---
function dydt = hpvModel(t, y, Lambda, beta, gamma, mu, alpha, delta, xi)
    % Ensure all states are non-negative
    y = max(y, 0);

    S = y(1); % Susceptible
    I = y(2); % Infected
    C = y(3); % Cancer
    R = y(4); % Recovered
    N = S + I + C + R; % Total population

    dS = Lambda - beta * S * I / N - mu * S;
    dI = beta * S * I / N - (gamma + alpha + mu) * I;
    dC = alpha * I - (xi + delta + mu) * C;
    dR = gamma * I + xi * C - mu * R;

    dydt = [dS; dI; dC; dR];
end
