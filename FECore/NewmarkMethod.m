function [U, V, A] = NewmarkMethod(tnts, dt, p, f, FV, Kff, Mff, dK, beta, gamma)
    U = zeros(length(f), tnts);
    V = zeros(length(f), tnts);
    A = zeros(length(f), tnts);

    % Initial conditions
    A(:,1) = Mff \ (FV(:,1) - Kff * U(:,1));  % Adjusted index FV(:,1)

    for n = 2 : tnts
        % Displacement Predictor
        U(:,n) = U(:,n-1) + dt * V(:,n-1) + dt^2 / 2 * (1 - 2 * beta) * A(:,n-1);
        
        % Velocity Predictor
        V(:,n) = V(:,n-1) + dt * (1 - gamma) * A(:,n-1);
        
        % Solution
        A(:,n) = dK \ (FV(:,n) - Kff * U(:,n));  % Adjusted index FV(:,n)
        
        % Displacement Corrector
        U(:,n) = U(:,n) + dt^2 * beta * A(:,n);
        
        % Velocity Corrector
        V(:,n) = V(:,n) + dt * gamma * A(:,n);
    end
end
