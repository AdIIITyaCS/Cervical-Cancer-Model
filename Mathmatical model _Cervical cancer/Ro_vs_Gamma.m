clear; clc; close all;
% Fixed values
S_tilde = 421.896 / 451.815;
beta = 0.4;
mu = 0.01;
delta = 0.1;
% Vary γ
gamma_vals = linspace(0.01, 1.0, 100);
R0_vals = (S_tilde * beta) ./ (gamma_vals + mu + delta);
% Compute bifurcation point (γ where R0 = 1)
gamma_bifurcation = (S_tilde * beta) - (mu + delta);
% Ensure the point is within the plotting range
if gamma_bifurcation > 0.01 && gamma_bifurcation <= 1.0
    R0_bifurcation = 1;
else
    gamma_bifurcation = NaN;
    R0_bifurcation = NaN;
end
% Plot
figure('Position', [100, 100, 800, 600]);
plot(gamma_vals, R0_vals, 'k', 'LineWidth', 2); hold on;
% Add horizontal line R0 = 1
yline(1, 'r--', '$R_0 = 1$', 'LineWidth', 1.5, 'FontSize', 20, 'Interpreter', 'latex');
% Annotate bifurcation point
if ~isnan(gamma_bifurcation)
    plot(gamma_bifurcation, R0_bifurcation, 'go', 'MarkerSize', 12, 'MarkerFaceColor', 'g');
    text(gamma_bifurcation + 0.02, R0_bifurcation + 0.15, ...
        sprintf('$\\gamma = %.4f$', gamma_bifurcation), ...
        'Color', 'k', 'FontSize', 16, 'Interpreter', 'latex');
end
xlabel('$\gamma$ (Recovery Rate)', 'FontSize', 24, 'Interpreter', 'latex');
ylabel('$R_0$ (Basic Reproduction Number)', 'FontSize', 24, 'Interpreter', 'latex');
title('$R_0$ vs $\gamma$ with Bifurcation Point', 'FontSize', 26, 'Interpreter', 'latex');
grid on;
box on;
set(gca, 'FontSize', 18);
% Add text annotations for stable and unstable regions
text(0.4, 2.5, 'Stable Region ($R_0 > 1$)', 'Color', 'k', 'FontSize', 16, 'Interpreter', 'latex');
text(0.4, 0.3, 'Unstable Region ($R_0 < 1$)', 'Color', 'k', 'FontSize', 16, 'Interpreter', 'latex');
% Save
saveas(gcf, 'R0_vs_gamma_with_bifurcation.jpg');
saveas(gcf, 'R0_vs_gamma_with_bifurcation.fig');
% Display key values in the console
fprintf('Fixed parameters:\n');
fprintf('S_tilde = %.6f\n', S_tilde);
fprintf('beta = %.2f\n', beta);
fprintf('mu = %.3f\n', mu);
fprintf('delta = %.2f\n', delta);
fprintf('\nBifurcation point: gamma = %.6f (where R₀ = 1)\n', gamma_bifurcation);