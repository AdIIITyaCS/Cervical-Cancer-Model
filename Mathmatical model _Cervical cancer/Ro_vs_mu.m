clear; clc; close all;
% Fixed values
S_tilde = 421.896 / 451.815; % Normalized susceptible population
beta = 0.4;                   % Infection rate
gamma = 0.2;                  % Fixed recovery rate
delta = 0.1;                  % Progression to cancer rate
% Vary μ (natural mortality rate)
mu_vals = linspace(0.001, 0.8, 100); % Range of μ values to plot
% Calculate R0 for each μ value using the formula: R0 = (S̃ · β)/(γ + μ + δ)
R0_vals = (S_tilde * beta) ./ (gamma + mu_vals + delta);
% Compute bifurcation point (μ where R0 = 1)
mu_bifurcation = (S_tilde * beta) - (gamma + delta);
% Check if bifurcation point exists
if mu_bifurcation >= 0.001
    % Find the closest point in our mu_vals to the theoretical bifurcation point
    [~, idx] = min(abs(mu_vals - mu_bifurcation));
    mu_bifurcation_plot = mu_vals(idx);
    R0_bifurcation_plot = R0_vals(idx);
else
    % If bifurcation point is less than 0.001, mark the leftmost point
    mu_bifurcation_plot = 0.001;
    R0_bifurcation_plot = (S_tilde * beta) / (gamma + 0.001 + delta);
end
% Display actual theoretical bifurcation point
fprintf('Theoretical bifurcation point (μ where R0 = 1): %.6f\n', mu_bifurcation);
% Create the plot
figure('Position', [100, 100, 800, 600]);
plot(mu_vals, R0_vals, 'k', 'LineWidth', 2);
hold on;
% Add horizontal line at R0 = 1
yline(1, 'r--', '$R_0 = 1$', 'LineWidth', 1.5, 'FontSize', 20, 'Interpreter', 'latex');
% Annotate bifurcation point on the graph
if mu_bifurcation >= 0.001
    % If bifurcation point is within our range, mark it properly
    plot(mu_bifurcation_plot, R0_bifurcation_plot, 'go', 'MarkerSize', 12, 'MarkerFaceColor', 'g');
    text(mu_bifurcation_plot + 0.02, R0_bifurcation_plot + 0.1, ...
        sprintf('$\\mu \\approx %.4f$', mu_bifurcation), ...
        'Color', 'k', 'FontSize', 16, 'Interpreter', 'latex');
else
    % If bifurcation point is to the left of our range, mark the leftmost point
    plot(mu_bifurcation_plot, R0_bifurcation_plot, 'go', 'MarkerSize', 12, 'MarkerFaceColor', 'g');
    text(mu_bifurcation_plot + 0.05, R0_bifurcation_plot + 0.2, ...
        sprintf('$\\mu < 0.001$\n$R_0(0.001) \\approx %.4f$', R0_at_min_mu), ...
        'Color', 'k', 'FontSize', 16, 'Interpreter', 'latex', 'VerticalAlignment', 'bottom');
end
% Add labels and title
xlabel('$\mu$ (Natural Mortality Rate)', 'FontSize', 24, 'Interpreter', 'latex');
ylabel('$R_0$ (Basic Reproduction Number)', 'FontSize', 24, 'Interpreter', 'latex');
title('$R_0$ vs $\mu$ with Bifurcation Point', 'FontSize', 26, 'Interpreter', 'latex');
% Add text annotations for stable and unstable regions
text(0.1, 0.4, 'Unstable Region ($R_0 < 1$)', 'Color', 'k', 'FontSize', 16, 'Interpreter', 'latex');
text(0.4, 1.2, 'Stable Region ($R_0 > 1$)', 'Color', 'k', 'FontSize', 16, 'Interpreter', 'latex');
% Improve graph appearance
grid on;
box on;
set(gca, 'FontSize', 18);
% Save the figure
saveas(gcf, 'R0_vs_mu_with_bifurcation.jpg');
saveas(gcf, 'R0_vs_mu_with_bifurcation.fig');
% Display key values in the console
fprintf('Fixed parameters:\n');
fprintf('S_tilde = %.6f\n', S_tilde);
fprintf('beta = %.2f\n', beta);
fprintf('gamma = %.2f\n', gamma);
fprintf('delta = %.2f\n', delta);
% Calculate the exact R0 value at mu = 0.001
R0_at_min_mu = (S_tilde * beta) / (gamma + 0.001 + delta);
fprintf('\nAt minimum mu = 0.001: R0 = %.6f\n', R0_at_min_mu);
fprintf('Bifurcation point (where R0 = 1): mu = %.6f\n', mu_bifurcation);