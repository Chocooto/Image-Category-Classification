function y = KLT_v2(x, label, d)
% KLT_V1 : KARHUNEN-LOEVE TRANSFORM FOR SUPERVISOR LEARNING
% ----------------------------------------------------------
% y = KLT_v2(x, label, th)
% x : input matrix N * D, D : dimension of features, N : number of samples
% label : classes
% d : number of features selected
% y : output matrix

dClass = classdata(x, label); dim = size(x,2);
[Mus, Sigmas, Ps] = classStat(dClass);
NumClasses = numel(Ps);
Sw = 0; Mut = 0; Sb = 0; J = zeros(NumClasses,1);

for c = 1:NumClasses
    Sw = Sw + Ps(c) * Sigmas{c};
    Mut = Mut + Mus{c} * Ps(c);
end
[U,D] = eig(Sw);
for c = 1:NumClasses
    dmu = (Mus{c}(:) - Mut(:));
    Sb = Sb + Ps(c) * (dmu * dmu');
end    
for i = 1:dim
    J(i) = U(:,i)' * Sb * U(:,i) / D(i,i);
end

[~, Is] = sort(J,'descend');
T = U(:,Is(1:d));
y = x * T;