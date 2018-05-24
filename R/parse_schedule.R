# FUNCTION TO PARSE SCHEDULE FILES
parse_schedule <- function(file) {

# SCAN SCHEDULE FILE
out <- scan(file = file, what="c", quiet=T, sep="\n")

# WHERE DOES HEADER START?
header_start <- grep("Rate Tried", out)

# SEPARATE SCHEDULE AND HEADER
schedule <- read.table(file, nrow = (header_start - 1), sep = "\t", header = FALSE)
names(schedule) <- c("operator","percent_tried")
header<- read.table(file, skip = (header_start - 1), sep = "\t", header = TRUE)
header<- header[,-ncol(header)]

# RETURN LIST
Schedule <- list(schedule=schedule, header=header)
return(Schedule)

}