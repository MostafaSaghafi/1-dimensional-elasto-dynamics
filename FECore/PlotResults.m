% PlotResults.m
function PlotResults(x, U, V, A)
    figure;
    subplot(3,1,1);
    plot(x, U);
    title('Displacement');
    xlabel('Position');
    ylabel('Displacement');

    subplot(3,1,2);
    plot(x, V);
    title('Velocity');
    xlabel('Position');
    ylabel('Velocity');

    subplot(3,1,3);
    plot(x, A);
    title('Acceleration');
    xlabel('Position');
    ylabel('Acceleration');
end
