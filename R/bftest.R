# FUNCTION TO PERFORM BAYES FACTOR TEST FOR TWO MODELS
bftest <-  function (model1, model2) {
  Hm1 <- 1/mean(1/model1$Log$results$Lh)
  Hm2 <- 1/mean(1/model2$Log$results$Lh)
	bf <- 2*(Hm1-Hm2)
	if (Hm1 < Hm2) {BetterModel <- "Model 2"; bf <- -bf} else {BetterModel <- "Model 1"}
	return(data.frame(BayesFactor = bf, BetterModel = BetterModel))
}