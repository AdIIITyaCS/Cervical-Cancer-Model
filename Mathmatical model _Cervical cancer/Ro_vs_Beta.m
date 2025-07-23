clear; clc; close all;
% Fixed values
S_tilde = 421.896 / 451.815;  % Normalized susceptible population
gamma = 0.2;                  % Fixed recovery rate
mu = 0.01;                    % Natural mortality rate
delta = 0.1;                  % Progression to cancer rate
% Vary β (infection rate)
beta_vals = linspace(0.01, 1.0, 100);  % Range of β values to plot
% Calculate R₀ for each β value using the formula: R₀ = (S̃ · β)/(γ + μ + δ)
R0_vals = (S_tilde * beta_vals) ./ (gamma + mu + delta);
% Compute bifurcation point (β where R₀ = 1)
beta_bifurcation = (gamma + mu + delta) / S_tilde;
% Ensure the bifurcation point is within the plotting range
if beta_bifurcation > 0.01 && beta_bifurcation <= 1.0
    R0_bifurcation = 1;
else
    % If bifurcation point is outside the range, don't mark it
    beta_bifurcation = NaN;
    R0_bifurcation = NaN;
end
% Create the plot
figure('Position', [100, 100, 800, 600]);
plot(beta_vals, R0_vals, 'k', 'LineWidth', 2);
hold on;
% Add horizontal line at R₀ = 1
yline(1, 'r--', '$R_0 = 1$', 'LineWidth', 1.5, 'FontSize', 20, 'Interpreter', 'latex');
% Annotate bifurcation point if it exists in our range
if ~isnan(beta_bifurcation)
    plot(beta_bifurcation, R0_bifurcation, 'go', 'MarkerSize', 12, 'MarkerFaceColor', 'g');
    text(beta_bifurcation + 0.05, R0_bifurcation + 0.10, ... % Adjusted x and y positions
        sprintf('$\\beta = %.4f$', beta_bifurcation), ...
        'Color', 'k', 'FontSize', 16, 'Interpreter', 'latex'); % Ensured LaTeX interpreter
end
% Add labels and title
xlabel('$\beta$ (Infection Rate)', 'FontSize', 24, 'Interpreter', 'latex');
ylabel('$R_0$ (Basic Reproduction Number)', 'FontSize', 24, 'Interpreter', 'latex');
title('$R_0$ vs $\beta$ with Bifurcation Point', 'FontSize', 26, 'Interpreter', 'latex');
% Add text annotations for stable and unstable regions
text(0.2, 2.0, 'Stable Region ($R_0 > 1$)', 'Color', 'k', 'FontSize', 16, 'Interpreter', 'latex');
text(0.4, 0.5, 'Unstable Region ($R_0 < 1$)', 'Color', 'k', 'FontSize', 16, 'Interpreter', 'latex');
% Improve graph appearance
grid on;
box on;
set(gca, 'FontSize', 18);
% Save the figure
saveas(gcf, 'R0_vs_beta_with_bifurcation.jpg');
saveas(gcf, 'R0_vs_beta_with_bifurcation.fig');
% Display key values in the console
fprintf('Fixed parameters:\n');
fprintf('S_tilde = %.6f\n', S_tilde);
fprintf('gamma = %.2f\n', gamma);
fprintf('mu = %.3f\n', mu);
fprintf('delta = %.2f\n', delta);
fprintf('\nBifurcation point: beta = %.6f (where R₀ = 1)\n', beta_bifurcation);