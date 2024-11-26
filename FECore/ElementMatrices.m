% ElementMatrices.m
function [Me, Ke, Fe] = ElementMatrices(tne, ngp, E, rho, x, egnn, nne, glw, N, B)
    Me = zeros(nne, nne, tne);  % Initialize mass matrix for each element
    Ke = zeros(nne, nne, tne);  % Initialize stiffness matrix for each element
    Fe = zeros(nne, 1  , tne);  % Initialize force vector for each element

    for en = 1 : tne
        for gs = 1 : ngp
            Jcbn = B(gs,:) * x(egnn(en,:));
            x_z  = N(gs,:) * x(egnn(en,:));
            force = (3*x_z + x_z^2) * exp(x_z);  % Example force calculation

            % Element Mass Matrix
            Me(:,:,en) = Me(:,:,en) + N(gs,:)' * rho * N(gs,:) * glw(gs) * Jcbn;
            % Element Stiffness Matrix
            Ke(:,:,en) = Ke(:,:,en) + B(gs,:)' / Jcbn * E * B(gs,:) / Jcbn * glw(gs) * Jcbn;
            % Element Force Vector
            Fe(:,1,en) = Fe(:,1,en) + N(gs,:)' * force * glw(gs) * Jcbn;
        end
    end
end
