lr.test = function (model1, model2) {
	Lh1 = model1$Lh
	Lh2 = model2$Lh
	if (length(Lh1) != length(Lh2)) {stop("Objects must contain the same number of models.")}
	LRstat = c()
	pval = c()
	for (n in 1:length(Lh1)) {
		lrs = 2*(Lh1[n] - Lh2[n])
		if (Lh1[n] < Lh2[n]) {lrs = -lrs}
		pv = pchisq(lrs, df=1, lower.tail=F) 
		LRstatistic = c(LRstatistic, lrs)
		pval = c(pval, pv)
	}
return(data.frame(Lh1, Lh2, LRstat, pval))
}
