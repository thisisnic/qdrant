upload_points <- function(x, name, data, encoder) {
  
  # next we need to split the points generation out of here - this will help us reduce our dependency on the specific encoder!!
  points <- lapply(1:nrow(data), function(idx) {
    doc <- data[idx, ] # Extract the row as a list
    vector <- encoder$encode(doc$notes) # Encode the "notes" field and convert to list
    qdrant_client$models$PointStruct(
      id = idx,
      vector = vector,
      payload = as.list(doc) # Convert the row to a list for payload
    )
  })
  
  x$upload_points(
    collection_name = name,
    points = points
  )
}
