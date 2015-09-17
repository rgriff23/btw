rj.models = function (model) {
	if (!("Model.string" %in% names(model))) {
		stop("'Model.string' not found: function requires output from a reversible jump BayesTraits analysis.")
	}
	NumModels = length(levels(model$Model.string))
	TopTen = sort(table(model $Model.string), decreasing=TRUE)[1:10]/nrow(model)
	return(list(NumModels=NumModels, TopTen=TopTen))
}