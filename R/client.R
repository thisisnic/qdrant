new_client <- function(path = NULL){
  if(is.null(path)){
    return(qdrant_client$QdrantClient(":memory:"))
  } else {
    return(qdrant_client$QdrantClient(path=path))
  }
}

