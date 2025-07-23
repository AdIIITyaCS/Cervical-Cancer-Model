% Define parameter values
gamma_val = 0.2;  
delta_val = 0.008;  
mu_val = 0.012;     

% Define parameters and corresponding sensitivity values
parameters = {'\beta', '\Lambda', '\gamma', '\delta', '\mu'};
sensitivity_values = [1, 1, -gamma_val/(delta_val + gamma_val + mu_val), ...
                      -(delta_val)/(delta_val + gamma_val + mu_val), ...
                      -(delta_val + gamma_val + 2*mu_val)/(delta_val + gamma_val + mu_val)];  

% Fix scaling issue
max_sensitivity = max(abs(sensitivity_values));
if max_sensitivity > 1.5
    scaling_factor = 1.5 / max_sensitivity;
    sensitivity_values = sensitivity_values * scaling_factor;
end

% Create a bar plot with green color
figure;
bar(sensitivity_values, 'FaceColor', [0 1 0]); 
set(gca, 'XTickLabel', parameters, 'FontSize', 14);
ylabel('Sensitivity Index');
xlabel('Parameters');
% title('Sensitivity Indices of R0 with Respect to Parameters');
ylim([-2 2]); % Set y-axis limits
grid on;