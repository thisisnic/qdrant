# helper function to skip tests if we don't have the 'foo' module
skip_if_no_qdrant_client <- function() {
  have_qdrant_client <- py_module_available("qdrant_client")
  if (!have_qdrant_client)
    skip("qdrant_client not available for testing")
}

# then call this function from all of your tests
# test_that("Things work as expected", {
#   skip_if_no_qdrant_client()
#   expect_true(TRUE)# test code here...
# })