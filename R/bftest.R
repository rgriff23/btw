bftest = function (model1, model2) {
	Hm1 = tail(model1$Harmonic.Mean, 1)
	Hm2 = tail(model2$Harmonic.Mean, 1)
	bf = 2*(Hm1-Hm2)
	if (Hm1 < Hm2) {BetterModel = "Model 2"; bf = -bf} else {BetterModel = "Model 1"}
	return(data.frame(BayesFactor = bf, BetterModel = BetterModel))
}