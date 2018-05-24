# FUNCTION TO PARSE ANCSTATES FILES
parse_ancstates <- function(file) {

# SCAN ANCSTATES FILE
out <- scan(file = file, what="c", quiet=T, sep="\n")

# WHERE DO THE RESULTS START
results_start <- grep("Itter", out)

# SEPARATE LIST OF NODES AND RESULTS TABLE
nodes <- readLines(file, n = (results_start - 1))
nodes <- sub("\t", ": ", nodes)
nodes <- gsub("\t", ", ", nodes)
nodes <- substr(nodes, 1, nchar(nodes)-2)
results <- read.table(file, skip = (results_start - 1), sep = "\t", header = TRUE)
results <- results[,-ncol(results)]

# RETURN LIST
AncStates<- list(nodes=nodes, results=results)
return(AncStates)

}

