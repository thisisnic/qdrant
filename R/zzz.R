# global reference to qdrant_client (will be initialized in .onLoad)
qdrant_client <- NULL

.onLoad <- function(libname, pkgname) {
  reticulate::use_virtualenv("r-qdrant_client", required = FALSE)
  
  # use superassignment to update global reference to qdrant_client
  qdrant_client <<- reticulate::import("qdrant_client", delay_load = TRUE)
  
  # # we need to disable parralelism otherwise we get errors about the process being forked
  if(Sys.getenv("TOKENIZERS_PARALLELISM") == ""){
    Sys.setenv("TOKENIZERS_PARALLELISM" = FALSE)
  }
}
