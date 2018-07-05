# FUNCTION TO RUN BAYESTRAITS FROM R
bayestraits <- function (data=NULL, tree=NULL, commands=NULL, silent=TRUE, remove_files=TRUE) {
  
  
  # WARNINGS (check class of arguments, species names in the data and tree, BayesTraits is in your directory)
  if (class(data) != "data.frame") stop("Data frame containing species data must be supplied")
  if (class(tree) == "phylo") {treelabs = tree$tip.label} else if (class(tree) == "multiPhylo") {treelabs = attributes(tree)$TipLabel} else {
    stop("Tree must be of class phylo or multiPhylo")
  }
  if (class(commands) != "character") stop("Character vector containing BayesTraits commands must be supplied.")
  if (!(class(data[,1]) %in% c("character", "factor"))) stop("First column of data must contain species names.")
  if (length(setdiff(treelabs, data[,1]))>0) stop(paste("No match found in the data:", paste(setdiff(tree$tip.label, data[,1]), collapse=", ")))
  if (length(setdiff(data[,1], treelabs))>0) stop(paste("No match found in the phylogeny:", paste(setdiff(data[,1], tree$tip.label), collapse=", ")))
  if(length(setdiff(treelabs, data[,1]))>0 | length(setdiff(data[,1], treelabs))>0) stop("Species in your phylogeny and data must match up exactly.")
  
  
  # DETECT SYSTEM 
  if (.Platform$OS.type == "windows") {
    windows = TRUE
  } else if (Sys.info()["sysname"] == "Darwin") {
    windows = FALSE
  } else {stop("Operating system not supported")}
  
  
  # CHECK FOR BAYESTRAITS IN WORKING DIRECTORY
  if (windows) {
    if (!("BayesTraitsV3.exe" %in% list.files())) stop("BayesTraitsV3.exe is not in your current working directory.")
  } else if (!("BayesTraitsV3" %in% list.files())) stop("BayesTraitsV3 is not in your current working directory.")
  dir <- getwd()
  
  
  # WRITE INPUT FILE, TREE, AND DATA
  write(c(commands, "run"), file = "./inputfile.txt")
  ape::write.nexus(tree, file = "./tree.nex", translate = T)
  write.table(data, file = "./data.txt", quote = F, col.names = F, row.names = F)
  
  
  # RUN BAYESTRAITS
  if (windows) {
    if (silent) {
      invisible(shell("BayesTraitsV3.exe tree.nex data.txt < inputfile.txt", intern = TRUE))
    } else {
      shell("BayesTraitsV3.exe tree.nex data.txt < inputfile.txt")
    }
  
  } else {
    system(paste(paste0(dir, "/BayesTraitsV3"), 
                 paste0(dir, "/tree.nex"), 
                 paste0(dir, "/data.txt"),
                 paste0("< ", dir, "/inputfile.txt")), 
           ignore.stdout = silent)
  }
  
  
  # CHECK WHICH OUTPUT IS THERE
  log <- "data.txt.Log.txt" %in% list.files()
  schedule <- "data.txt.Schedule.txt" %in% list.files()
  stones <- "data.txt.Stones.txt" %in% list.files()
  ancstates <- "data.txt.AncStates.txt" %in% list.files()
  output.trees <- "data.txt.Output.trees" %in% list.files()
  varrates <- "data.txt.VarRates" %in% list.files()
  if (!log) stop("Something went wrong: btw can't find a log file")
  if (varrates) warning("btw does not handle output from a variable rates model.")
  
  
  # CAPTURE AND PARSE OUTPUT
  if (windows) {
    Log <- parse_log("data.txt.Log.txt")
    if (schedule) Schedule <- parse_schedule("data.txt.Schedule.txt") else Schedule <- NULL
    if (stones) Stones <- parse_stones("data.txt.Stones.txt") else Stones <- NULL
    if (ancstates) AncStates <- parse_ancstates("data.txt.AncStates.txt") else AncStates <- NULL
    if (output.trees) OutputTrees <- ape::read.nexus("data.txt.Output.trees") else OutputTrees <- NULL
  } else {
    Log <- parse_log(paste0(dir, "/data.txt.Log.txt"))
    if (schedule) Schedule <- parse_schedule(paste0(dir, "/data.txt.Schedule.txt")) else Schedule <- NULL
    if (stones) Stones <- parse_stones(paste0(dir, "/data.txt.Stones.txt")) else Stones <- NULL
    if (ancstates) AncStates <- parse_ancstates(paste0(dir, "/data.txt.AncStates.txt")) else AncStates <- NULL
    if (output.trees) OutputTrees <- ape::read.nexus(paste0(dir, "/data.txt.Output.trees")) else OutputTrees <- NULL
  }
  results <- list(Log=Log,
                  Schedule=Schedule,
                  Stones=Stones,
                  AncStates=AncStates,
                  OutputTrees=OutputTrees)
  
  # REMOVE OUTPUT FILES FROM DISK
  if (remove_files) {
    if (windows) {
      shell(paste("DEL", "data.txt.Log.txt"))
      shell(paste("DEL", "data.txt"))
      shell(paste("DEL", "tree.nex"))
      shell(paste("DEL", "inputfile.txt"))
      if (schedule) shell("DEL", "data.txt.Schedule.txt")
      if (stones) shell("DEL", "data.txt.Stones.txt")
      if (ancstates) shell("DEL", "data.txt.AncStates.txt")
      if (output.trees) shell("DEL", "data.txt.Output.trees")
    } else {
      system(paste0("rm ", dir, "/data.txt.Log.txt"))
      system(paste0("rm ", dir, "/data.txt"))
      system(paste0("rm ", dir, "/tree.nex"))
      system(paste0("rm ", dir, "/inputfile.txt"))
      if (schedule) system(paste0("rm ", dir, "/data.txt.Schedule.txt"))
      if (stones) system(paste0("rm ", dir, "/data.txt.Stones.txt"))
      if (ancstates) system(paste0("rm ", dir, "/data.txt.AncStates.txt"))
      if (output.trees) system(paste0("rm ", dir, "/data.txt.Output.trees"))
    }
  }
  
  # RETURN RESULTS
  return(results)
}