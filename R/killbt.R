# FUNCTION TO KILL ALL BAYESTRAITS PROCESSES
killbt <- function() {
  
  # DETECT SYSTEM
  if (.Platform$OS.type == "windows") {
    windows = TRUE
  } else if (Sys.info()["sysname"] == "Darwin") {
    windows = FALSE
  } else {stop("Operating system not supported")}
  
  # KILL PROCESSES
  if (windows) {
    system('taskkill /f /im BayesTraits*')
  } else {
    jobs <- system("pgrep BayesTraits", intern=T)
    for (n in 1:length(jobs)) {system(paste("kill", jobs[n]))}
  }
  
}

