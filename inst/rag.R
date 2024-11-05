# this script shows how we can do everything except for the encoder in r!!
# will this work if we use a different (R-based) encoder?!
# I think ultimately, yes - we just need to have the encoded notes and the encoded prompt -
# we can change it so we don't have to pass in the encoder to `upload_points`

library(reticulate)
use_virtualenv("r-qdrant_client")
devtools::load_all()

# set up encoder

st <- import("sentence_transformers")
encoder <- st$SentenceTransformer('all-MiniLM-L6-v2')

r_qdrant <- new_client()
create_collection(r_qdrant, "top_wines", encoder$get_sentence_embedding_dimension())

# Read the CSV file into a data frame
df <- read.csv(system.file("top_rated_wines.csv", package="qdrant"))

# Remove any rows where 'variety' is NA
df <- df[!is.na(df$variety), ]

# Randomly sample 700 rows
set.seed(123) # Set seed for reproducibility, if needed
sampled_indices <- sample(1:nrow(df), 700)
data <- df[sampled_indices, ]

user_prompt <- "A wine from Mendoza Argentina"

upload_points(r_qdrant, "top_wines", data, encoder)

encoded_prompt = encoder$encode(user_prompt)

hits = search(r_qdrant, "top_wines", encoded_prompt, limit=3L)

hits
