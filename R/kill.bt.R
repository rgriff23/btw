kill.bt = function() {
	jobs = system("pgrep BayesTraits", intern=T)
	for (n in 1:length(jobs)) {system(paste("kill", jobs[n]))}
}

