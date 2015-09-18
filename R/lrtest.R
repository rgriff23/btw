lrtest = function (model1, model2) {
	if (nrow(model1) != nrow(model2)) {stop("Objects must contain the same number of models.")}
	Lhs = c(mean(model1$Lh), mean(model2$Lh))
	ind = sort(Lhs, index.return=TRUE)$ix
	max = which.max(c(model1$Lh, model2$Lh))
	Lh1 = Lhs[ind[1]]
	Lh2 = Lhs[ind[2]]
	LRstat = c()
	pval = c()
	for (n in 1:length(Lh1)) {
		lrs = 2*(Lh1[n] - Lh2[n])
		if (Lh1[n] < Lh2[n]) {lrs = -lrs}
		pv = pchisq(lrs, df=1, lower.tail=F) 
		LRstat = c(LRstat, lrs)
		pval = c(pval, pv)
	}
return(data.frame(model1$Lh, model2$Lh, LRstat, pval))
}
