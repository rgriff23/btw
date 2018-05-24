# FUNCTION TO PARSE LOG FILES
parse_log <- function(file) {

# SCAN LOG FILE
out <- scan(file = file, what="c", quiet=T, sep="\n")

# ML OR MCMC?
mcmc <- ifelse(length(out[grep("Maximum Likelihood", out)]) == 0, TRUE, FALSE)
results_start <- ifelse(mcmc, "Iteration\\s", "Tree No")
results_start <- grep(results_start, out)

# SEPARATE MODEL OPTIONS AND RESULTS
options <- readLines(file, n = (results_start - 1))
results <- read.table(file, skip = (results_start - 1), sep = "\t", header = TRUE)
results <- results[,-ncol(results)]

# RETURN LIST
Log <- list(options=options, results=results)
return(Log)

}
