#' @export
upload_points <- function(x, collection_name, points, batch_size = 64, parallel = 1, method = NULL, max_retries = 3, 
                          wait = FALSE, shard_key_selector = NULL, ...) {
  
  x$upload_points(
    collection_name = collection_name, 
    points = points, 
    batch_size = batch_size, 
    parallel = parallel, 
    method = method, 
    max_retries = max_retries,
    wait = wait,
    shard_key_selector = shard_key_selector,
    ... 
  )
}

# TODO: rename this, look at keras model for doing this
construct_points <- function(data, encoder){
  lapply(1:nrow(data), function(idx) {
    doc <- data[idx, ] # Extract the row as a list
    vector <- encoder$encode(doc$notes) # Encode the "notes" field and convert to list
    qdrant_client$models$PointStruct(
      id = idx,
      vector = vector,
      payload = as.list(doc) # Convert the row to a list for payload
    )
  })
}