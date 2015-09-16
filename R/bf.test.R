bf.test = function (model1, model2) {
	if ("Harmonic.Mean" %in% names(model1)) {
		Hm1 = tail(model1$Results$Harmonic.Mean, 1)
		Hm2 = tail(model2$Results$Harmonic.Mean, 1)
	}
	if ("HMean"%in% names(model1$Results)) {
		Hm1 = tail(model1$Results$HMean, 1)
		Hm2 = tail(model2$Results$HMean, 1)
	}
	bf = 2*(Hm1-Hm2)
	if (Hm1 < Hm2) {BetterModel = "Model 2"; bf = -bf} else {BetterModel = "Model 1"}
	return(data.frame(BayesFactor = bf, BetterModel = BetterModel))
}