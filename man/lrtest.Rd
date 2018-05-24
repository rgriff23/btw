\name{lrtest}
\alias{lrtest}
\title{Likelihood ratio test for BayesTraitsV3 models.}
\usage{
lrtest(model1, model2)
}
\description{
	Perform likelihood ratio test for a pair of \code{bayestraits} results. 
}
\arguments{
  \item{model1}{output from \code{bayestraits} in Maximum Likelihood mode. Can include one or more models, but must have the same number of models as model2.}
  \item{model2}{output from \code{bayestraits} in Maximum Likelihood mode. Can include one or more models, but must have the same number of models as model1.}
}
\details{
	If there are multiple models in the \code{bayestraits} output (e.g., models were fit across a sample of phylogenies), then the likelihood ratio test is performed for each pair of models and a separate row of results is generated for each pair.
}
\value{
	Results from likelihood ratio test(s) in a dataframe.
}
\author{
	Randi H. Griffin 
}
\references{
	Wilks, S.S. (1938). "The Large-Sample Distribution of the Likelihood Ratio for Testing Composite Hypotheses". The Annals of Mathematical Statistics 9: 60-62. 
}


