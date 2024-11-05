install_qdrant_client <- function(envname = "r-qdrant_client", method = "auto", ...) {
  reticulate::py_install("qdrant_client", envname = envname, 
                         method = method, ...)
}