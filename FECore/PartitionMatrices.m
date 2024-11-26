% PartitionMatrices.m
function [Kpp, Kpf, Kfp, Kff, Mpp, Mpf, Mfp, Mff] = PartitionMatrices(barK, barM, p, f)
    Kpp = barK(p,p);
    Kpf = barK(p,f);
    Kfp = barK(f,p);
    Kff = barK(f,f);
    Mpp = barM(p,p);
    Mpf = barM(p,f);
    Mfp = barM(f,p);
    Mff = barM(f,f);
end
