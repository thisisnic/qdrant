#' @export
qdrant <- function(location = NULL, url = NULL, port = 6333L, grpc_port = 6334L,
                          prefer_grpc = FALSE, https = NULL, api_key = NULL, prefix = NULL,
                          timeout = NULL, host = NULL, path = NULL, force_disable_check_same_thread = FALSE,
                          grpc_options = NULL, auth_token_provider = NULL, ...) {
  
  qdrant_client$QdrantClient(
    location = location,
    url = url,
    port = port, 
    grpc_port = grpc_port, 
    prefer_grpc = prefer_grpc, 
    https = https, 
    api_key = api_key, 
    prefix = prefix,
    timeout = timeout, 
    host = host, 
    path = path, 
    force_disable_check_same_thread = force_disable_check_same_thread, 
    grpc_options = grpc_options, 
    auth_token_provider = auth_token_provider,
    ...
  )
}