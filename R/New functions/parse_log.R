# FUNCTION TO PARSE LOG FILES
parse_log <- function(file) {

# SCAN LOG FILE
out <- scan(file = file, what="c", quiet=T, sep="\n")

# ML OR MCMC?
analysis_type <- out[grep("Analysis Type", out)]
results_start <- ifelse(grepl("MCMC", analysis_type), "Iteration\\s", "Tree No")
results_start <- grep(results_start, out)

# SEPARATE MODEL OPTIONS AND RESULTS
options <- readLines(file, n = (results_start - 1))
results <- read.table(file, skip = (results_start - 1), sep = "\t", header = TRUE)
results <- results[,-ncol(results)]

# RETURN LIST
Log <- list(options=options, results=results)
return(Log)

}
