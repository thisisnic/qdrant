# global reference to qdrant_client (will be initialized in .onLoad)
qdrant_client <- NULL
sentence_transformers_temp_delete <- NULL

.onLoad <- function(libname, pkgname) {
  # use superassignment to update global reference to qdrant_client
  qdrant_client <<- reticulate::import("qdrant_client", delay_load = TRUE)
  sentence_transformers_temp_delete <<- reticulate::import("sentence_transformers", delay_load = TRUE)
  reticulate::use_virtualenv("r-qdrant_client", required = FALSE)
}