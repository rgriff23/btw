# FUNCTION TO PARSE STONES FILES
parse_stones <- function(file) {

# SCAN STONES FILE
out <- scan(file = file, what="c", quiet=T, sep="\n")

# WHERE DOES DIAGNOSTICS TABLE START
analysis_type <- out[grep("Analysis Type", out)]
results_start <- ifelse(grepl("MCMC", analysis_type), "Iteration\\s", "Tree No")
diagnostics_start <- grep("Stone No", out)
lml <- length(out)

# SEPARATE OPTIONS, DIAGNOSTICS TABLE, AND LOG MARGINAL LIKELIHOOD
options <- readLines(file, n = (diagnostics_start - 1))
diagnostics <- read.table(file, skip = (diagnostics_start - 1), nrow = (lml - diagnostics_start - 1), sep = "\t", header = TRUE)
lml <- as.numeric(strsplit(out[lml], "\t")[[1]][2])


# RETURN LIST
Stones <- list(options=options, diagnostics=diagnostics, logMarLH=lml)
return(Stones)

}

