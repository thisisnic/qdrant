
# qdrant

<!-- badges: start -->
<!-- badges: end -->

The goal of qdrant is to ...

## Installation

You can install the development version of qdrant from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("thisisnic/qdrant")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(qdrant)
r_qdrant <- new_client()
col <- create_collection(r_qdrant, "top_wines", 384)

# we should use margrittr so we can do like

# Read the CSV file into a data frame
df <- read.csv(system.file("top_rated_wines.csv", package="qdrant"))

# Remove any rows where 'variety' is NA
df <- df[!is.na(df$variety), ]

# Randomly sample 700 rows
set.seed(123) # Set seed for reproducibility, if needed
sampled_indices <- sample(1:nrow(df), 700)
data <- df[sampled_indices, ]


user_prompt <- "A wine from Mendoza Argentina"
encoder <- sentence_transformers_temp_delete$SentenceTransformer('all-MiniLM-L6-v2')


r_qdrant %>%
  create_collection("top_wines", 384) %>%
  upload_points("top_wines", data)
  

```

