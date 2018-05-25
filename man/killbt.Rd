\name{killbt}
\alias{killbt}
\title{Kill all BayesTraits processes on computer.}
\usage{
killbt()
}
\description{
	Kill all BayesTraits processes on computer.
}
\details{
	Escaping from Continuous or Discrete within R does not mean that the BayesTraits analysis has stopped on your computer, and analyses running in the background can really slow things down. If you start a long BayesTraits process and want to quit it, first hit ESC to quit the function within R, and then run \code{killbt()} to stop the processes from running in the background on your computer. If you can't escape the function in R, you might need to restart R, but BayesTraits may still be running in your background, so the first thing you should do is run \code{killbt()} as soon as you start the new session.
}
\author{
	Randi H. Griffin 
}



