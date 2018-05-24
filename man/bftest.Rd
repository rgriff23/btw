\name{bftest}
\alias{bftest}
\title{BayesFactor test for BayesTraitsV3 models.}
\usage{
bftest(model1, model2)
}
\description{
	Perform Bayes factor test for a pair of \code{bayestraits} results. 
}
\arguments{
  \item{model1}{output from \code{bayestraits} in MCMC mode}
  \item{model2}{output from \code{bayestraits} in MCMC mode}
}
\value{
	Results from Bayes factor test in a dataframe.
}
\author{
	Randi H. Griffin 
}
\references{
	Bernardo, J., Smith, A.F.M. (1994). "Bayesian Theory". John Wiley.
}


