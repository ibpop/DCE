function [LL,g,h] = LL_mimic_MATlike(Xstr, Xmea,Xmea_exp, err, EstimOpt, OptimOpt, b0)

LLfun = @(B) LL_mimic(Xstr, Xmea,Xmea_exp, err, EstimOpt,B);


[f,j] = LLfun(b0);
        j(:,EstimOpt.BActive ==0) = 0;
        g = sum(j,1)'; ...


f2 = LLfun(b0);  
        j2 = numdiff(LLfun,f2,b0,isequal(OptimOpt.FinDiffType,'central'),EstimOpt.BActive);...
        g2 = sum(j2,1)';  
[g,g2]
pause;

if isequal(OptimOpt.GradObj,'on')
    if EstimOpt.NumGrad == 0
        [f,j] = LLfun(b0);
        j(:,EstimOpt.BActive ==0) = 0;
        g = sum(j,1)'; ...
            
        if isequal(OptimOpt.Hessian,'user-supplied') == 1
            h = j'*j;
        end
    else % => EstimOpt.NUMGRAD == 1 
        f = LLfun(b0);  
        j = numdiff(LLfun,f,b0,isequal(OptimOpt.FinDiffType,'central'),EstimOpt.BActive);...
        g = sum(j,1)';   
        if isequal(OptimOpt.Hessian,'user-supplied') == 1
            h = j'*j;
        end
    end
else % No gradient
    EstimOpt.NumGrad = 1;
    f = LLfun(b0);   
end

LL = sum(f);
% LL
% g
% pause;
% sum(isnan(j),1)
% indx = find(isnan(j(:,1)));
% [f(indx), j(indx,:)]
% indx
% Xmea(indx,:)
%pause;
