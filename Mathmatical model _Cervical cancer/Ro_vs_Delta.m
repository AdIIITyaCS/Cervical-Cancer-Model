clear; clc; close all;
% Fixed values
S_tilde = 421.896 / 451.815;  % Normalized susceptible population
beta = 0.4;                   % Infection rate
gamma = 0.2;                  % Fixed recovery rate
mu = 0.01;                    % Fixed natural mortality rate
% Vary δ (progression to cancer rate)
delta_vals = linspace(0.001, 0.6, 100);  % Range of δ values to plot
% Calculate R₀ for each δ value using the formula: R₀ = (S̃ · β)/(γ + μ + δ)
R0_vals = (S_tilde * beta) ./ (gamma + mu + delta_vals);
% Compute bifurcation point (δ where R₀ = 1)
delta_bifurcation = (S_tilde * beta) - (gamma + mu);
% Ensure the bifurcation point is within the plotting range
if delta_bifurcation > 0.001 && delta_bifurcation <= 0.6
    R0_bifurcation = 1;
else
    % If bifurcation point is outside the range, don't mark it
    delta_bifurcation = NaN;
    R0_bifurcation = NaN;
end
% Create the plot
figure('Position', [100, 100, 800, 600]);
plot(delta_vals, R0_vals, 'k', 'LineWidth', 2);
hold on;
% Add horizontal line at R₀ = 1
yline(1, 'r--', '$R_0 = 1$', 'LineWidth', 1.5, 'FontSize', 20, 'Interpreter', 'latex');
% Annotate bifurcation point if it exists in our range
if ~isnan(delta_bifurcation)
    plot(delta_bifurcation, R0_bifurcation, 'go', 'MarkerSize', 12, 'MarkerFaceColor', 'g');
    text(delta_bifurcation + 0.02, R0_bifurcation + 0.1, ...
        sprintf('$\\delta = %.4f$', delta_bifurcation), ...
        'Color', 'k', 'FontSize', 16, 'Interpreter', 'latex');
end
% Add labels and title
xlabel('$\delta$ (Progression to Cancer Rate)', 'FontSize', 24, 'Interpreter', 'latex');
ylabel('$R_0$ (Basic Reproduction Number)', 'FontSize', 24, 'Interpreter', 'latex');
title('$R_0$ vs $\delta$ with Bifurcation Point', 'FontSize', 26, 'Interpreter', 'latex');
% Add text annotations for stable and unstable regions
text(0.1, 0.7, 'Unstable Region ($R_0 < 1$)', 'Color', 'k', 'FontSize', 16, 'Interpreter', 'latex');
text(0.3, 1.4, 'Stable Region ($R_0 > 1$)', 'Color', 'k', 'FontSize', 16, 'Interpreter', 'latex');
% Improve graph appearance
grid on;
box on;
set(gca, 'FontSize', 18);
% Save the figure
saveas(gcf, 'R0_vs_delta_with_bifurcation.jpg');
saveas(gcf, 'R0_vs_delta_with_bifurcation.fig');
% Display key values in the console
fprintf('Fixed parameters:\n');
fprintf('S_tilde = %.6f\n', S_tilde);
fprintf('beta = %.2f\n', beta);
fprintf('gamma = %.2f\n', gamma);
fprintf('mu = %.3f\n', mu);
fprintf('\nBifurcation point: delta = %.6f (where R₀ = 1)\n', delta_bifurcation);