search <- function(x, collection_name, query_vector, query_filter = NULL, 
                   search_params = NULL, limit = 10L, offset = NULL, with_payload = TRUE, 
                   with_vectors = FALSE, score_threshold = NULL, append_payload = TRUE, 
                   consistency = NULL, shard_key_selector = NULL, timeout = NULL, 
                   ...){

  # the query vector needs to be a mutable numpy array as currently it being immutable causes problems  
  np <- reticulate::import("numpy", convert = FALSE)
  mutable_query_vector <- np$array(query_vector)

  results <- x$search(
    collection_name = collection_name, 
    query_vector = mutable_query_vector, 
    query_filter = query_filter, 
    search_params = search_params, 
    limit = limit, 
    offset = offset, 
    with_payload = with_payload, 
    with_vectors = with_vectors, 
    score_threshold = score_threshold, 
    append_payload = append_payload, 
    consistency = consistency, 
    shard_key_selector = shard_key_selector,
    timeout = timeout, 
    ...
  )
  
  results
  
}
