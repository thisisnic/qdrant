upload_points <- function(x, name, data, encoder) {
  points <- lapply(1:nrow(data), function(idx) {
    doc <- data[idx, ] # Extract the row as a list
    vector <- encoder$encode(as.character(doc$notes))$tolist() # Encode the "notes" field and convert to list
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

# qdrant.upload_points(
#   collection_name="top_wines",
#   points=[
#     models.PointStruct(
#       id=idx,
#       vector=encoder.encode(doc["notes"]).tolist(),
#       payload=doc,
#     ) for idx, doc in enumerate(data) # data is the variable holding all the wines
#   ]
# )