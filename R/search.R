search <- function(x, collection_name, query_vector, query_filter = NULL, 
                   search_params = NULL, limit = 10L, offset = NULL, with_payload = TRUE, 
                   with_vectors = FALSE, score_threshold = NULL, append_payload = TRUE, 
                   consistency = NULL, shard_key_selector = NULL, timeout = NULL, 
                   ...){

  # the query vector needs to be a mutable numpy array as currently it being immutable causes problems  
  np <- reticulate::import("numpy", convert = FALSE)
  numpy_array <- np$array(query_vector)

  x$search(
    collection_name=collection_name,
    query_vector=numpy_array,
    limit=limit
  )
}
