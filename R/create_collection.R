create_collection <- function(x, collection_name, vectors_config = NULL, sparse_vectors_config = NULL, 
                              shard_number = NULL, sharding_method = NULL, replication_factor = NULL, 
                              write_consistency_factor = NULL, on_disk_payload = NULL, hnsw_config = NULL,
                              optimizers_config = NULL, wal_config = NULL, quantization_config = NULL, 
                              init_from = NULL, timeout = NULL, ...){
  
  x$create_collection(
    collection_name = collection_name, vectors_config = vectors_config, sparse_vectors_config = sparse_vectors_config, 
    shard_number = shard_number, sharding_method = sharding_method, replication_factor = replication_factor, 
    write_consistency_factor = write_consistency_factor, on_disk_payload = on_disk_payload, hnsw_config = hnsw_config, 
    optimizers_config = optimizers_config, wal_config = wal_config, quantization_config = quantization_config, 
    init_from = init_from, timeout = timeout, ...
  )

}

vector_params <- function(..., size, distance, hnsw_config = NULL, quantization_config = NULL, on_disk = NULL, datatype = NULL){
  

  invisible(
    qdrant_client$models$VectorParams(
      ...,
      size = size,
      distance = distance,
      hnsw_config = hnsw_config,
      quantization_config = quantization_config,
      on_disk = on_disk,
      datatype = datatype
    )
  )
}
