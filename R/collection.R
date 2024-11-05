create_collection <- function(x, name, size, distance = "cosine"){
  x$create_collection(
    collection_name=name,
    vectors_config=qdrant_client$models$VectorParams(
      size=size, # Vector size is defined by used model
      distance=get_distance(distance)
    )
  )
}

get_distance <- function(distance){
  if(distance == "cosine"){
    return(qdrant_client$models$Distance$COSINE)
  }
}

