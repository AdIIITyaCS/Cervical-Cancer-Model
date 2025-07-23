% Fixed parameters
S = 0.933;         % ~S updated value
fixed_beta = 0.5;
fixed_gamma = 0.2;
fixed_mu = 0.1;
fixed_delta = 0.05;

% Range for parameters to plot
x_vals = linspace(0.01, 1, 200);
y_vals = linspace(0.01, 1, 200);

figure;
set(gcf, 'Position', [100 100 1200 800]);

% (a) beta vs gamma
[BETA, GAMMA] = meshgrid(x_vals, y_vals);
R0 = (S .* BETA) ./ (GAMMA + fixed_mu + fixed_delta);
subplot(2, 3, 1);
contourf(BETA, GAMMA, R0 < 1, [0 1], 'LineColor', 'none');
colormap([0 0 1; 1 1 0]); hold on;
contour(BETA, GAMMA, R0, [1 1], 'k', 'LineWidth', 2);
xlabel('\beta'); ylabel('\gamma'); title('(a) \beta vs \gamma');
text(0.75, 0.15, 'R_0 > 1', 'Color', 'k', 'BackgroundColor', [1 1 0], 'FontWeight', 'bold');
text(0.1, 0.9, 'R_0 < 1', 'Color', 'w', 'BackgroundColor', [0 0 1], 'FontWeight', 'bold');
text(0.5, 0.5, 'R_0 = 1', 'Color', 'k', 'FontWeight', 'bold', 'HorizontalAlignment', 'center');

% (b) beta vs mu
[BETA, MU] = meshgrid(x_vals, y_vals);
R0 = (S .* BETA) ./ (fixed_gamma + MU + fixed_delta);
subplot(2, 3, 2);
contourf(BETA, MU, R0 < 1, [0 1], 'LineColor', 'none');
colormap([0 0 1; 1 1 0]); hold on;
contour(BETA, MU, R0, [1 1], 'k', 'LineWidth', 2);
xlabel('\beta'); ylabel('\mu'); title('(b) \beta vs \mu');
text(0.75, 0.15, 'R_0 > 1', 'Color', 'k', 'BackgroundColor', [1 1 0], 'FontWeight', 'bold');
text(0.1, 0.9, 'R_0 < 1', 'Color', 'w', 'BackgroundColor', [0 0 1], 'FontWeight', 'bold');
text(0.5, 0.4, 'R_0 = 1', 'Color', 'k', 'FontWeight', 'bold', 'HorizontalAlignment', 'center');

% (c) beta vs delta
[BETA, DELTA] = meshgrid(x_vals, y_vals);
R0 = (S .* BETA) ./ (fixed_gamma + fixed_mu + DELTA);
subplot(2, 3, 3);
contourf(BETA, DELTA, R0 < 1, [0 1], 'LineColor', 'none');
colormap([0 0 1; 1 1 0]); hold on;
contour(BETA, DELTA, R0, [1 1], 'k', 'LineWidth', 2);
xlabel('\beta'); ylabel('\delta'); title('(c) \beta vs \delta');
text(0.75, 0.15, 'R_0 > 1', 'Color', 'k', 'BackgroundColor', [1 1 0], 'FontWeight', 'bold');
text(0.1, 0.9, 'R_0 < 1', 'Color', 'w', 'BackgroundColor', [0 0 1], 'FontWeight', 'bold');
text(0.5, 0.4, 'R_0 = 1', 'Color', 'k', 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
% (d) gamma vs mu
[GAMMA, MU] = meshgrid(x_vals, y_vals);
R0 = (S .* fixed_beta) ./ (GAMMA + MU + fixed_delta);
subplot(2, 3, 4);
contourf(GAMMA, MU, R0 < 1, [0 1], 'LineColor', 'none');
colormap([0 0 1; 1 1 0]); hold on;
contour(GAMMA, MU, R0, [1 1], 'k', 'LineWidth', 2);
xlabel('\gamma'); ylabel('\mu'); title('(d) \gamma vs \mu');
text(0.05, 0.05, 'R_0 > 1', 'Color', 'r','FontWeight', 'bold');
text(0.05, 0.75, 'R_0 < 1', 'Color', 'k', 'FontWeight', 'bold');
text(0.3, 0.3, 'R_0 = 1', 'Color', 'k', 'FontWeight', 'bold', 'HorizontalAlignment', 'center');

% (e) gamma vs delta
[GAMMA, DELTA] = meshgrid(x_vals, y_vals);
R0 = (S .* fixed_beta) ./ (GAMMA + fixed_mu + DELTA);
subplot(2, 3, 5);
contourf(GAMMA, DELTA, R0 < 1, [0 1], 'LineColor', 'none');
colormap([0 0 1; 1 1 0]); hold on;
contour(GAMMA, DELTA, R0, [1 1], 'k', 'LineWidth', 2);
xlabel('\gamma'); ylabel('\delta'); title('(e) \gamma vs \delta');
text(0.05, 0.05, 'R_0 > 1', 'Color', 'r', 'FontWeight', 'bold');
text(0.05, 0.75, 'R_0 < 1', 'Color', 'k', 'FontWeight', 'bold');
text(0.3, 0.3, 'R_0 = 1', 'Color', 'k', 'FontWeight', 'bold', 'HorizontalAlignment', 'center');


% (f) mu vs delta

[DELTA, MU] = meshgrid(x_vals, y_vals);  % Swap order to ensure X=mu, Y=delta
R0 = (S .* fixed_beta) ./ (fixed_gamma + MU + DELTA);  % Same formula
subplot(2, 3, 6);
contourf(DELTA, MU, R0 < 1, [0 1], 'LineColor', 'none');
colormap([0 0 1; 1 1 0]); hold on;
contour(DELTA, MU, R0, [1 1], 'k', 'LineWidth', 2);
xlabel('\mu'); ylabel('\delta'); title('(f) \mu vs \delta');
text(0.05, 0.05, 'R_0 > 1', 'Color', 'r', 'FontWeight', 'bold');
text(0.05, 0.9, 'R_0 < 1', 'Color', 'k',  'FontWeight', 'bold');
text(0.3, 0.3, 'R_0 = 1', 'Color', 'k', 'FontWeight', 'bold', 'HorizontalAlignment', 'center');
