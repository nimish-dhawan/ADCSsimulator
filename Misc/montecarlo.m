% Nimish Dhawan 2025
% Monte Carlo Setup

N = 20;
tspan = 7200;
simOut = cell(N,1);

for i = 1:N
    simOut{i} = sim("ADCS_onOrbit.slx");
end

%%
figure
hold on
for k = 1:N
    plot(simOut{k}.tout, squeeze(simOut{k}.w2_meas), 'Color', [0.7 0.7 0.7])
end
hold off

t = simOut{1}.tout;
W = zeros(length(t), N);

for i = 1:N
    W(:,i) = squeeze(simOut{k}.w2_est);
end

mu = mean(W,2);
sig = std(W,0,2);

figure
plot(t, mu, 'k', 'LineWidth', 0.75); hold on
plot(t, mu + 3*sig, 'r--');
plot(t, mu - 3*sig, 'r--');