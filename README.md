
<!-- README.md is generated from README.Rmd. Please edit that file -->

# qdrant

<!-- badges: start -->
<!-- badges: end -->

The goal of qdrant is to …

## Installation

You can install the development version of qdrant from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("thisisnic/qdrant")
```

## Example

Let’s take a look at populating an in-memory vector database and then
searching it.

We start by setting up the data we want to use in our analysis.

``` r
library(reticulate)
devtools::load_all(".")
#> ℹ Loading qdrant
```

``` r

# Read the CSV file into a data frame
df <- read.csv(system.file("top_rated_wines.csv", package="qdrant"))

# Remove any rows where 'variety' is NA
df <- df[!is.na(df$variety), ]

# Randomly sample 700 rows
set.seed(123) # Set seed for reproducibility, if needed
sampled_indices <- sample(1:nrow(df), 700)
data <- df[sampled_indices, ]
```

Next, we create the user prompt we want to use to search the data

``` r
user_prompt <- "A wine from Mendoza Argentina"
```

Then we encode both the data and user prompt - here I’m using the Python
`sentence_transformers` library to do this.

``` r
# set up encoder
st <- import("sentence_transformers")
encoder <- st$SentenceTransformer('all-MiniLM-L6-v2')
embedding_size <- encoder$get_sentence_embedding_dimension()

# encode input data and user prompt
encoded_data <- construct_points(data, encoder)

# Encode user prompt
encoded_prompt <- encoder$encode(user_prompt)
```

Now we initialise a new qdrant instance in memory

``` r
r_qdrant <- qdrant(":memory:")
```

We initialise the collection with our data

``` r
create_collection(
  r_qdrant,
  "top_wines", 
  vectors_config = vector_params(size = embedding_size, distance = "Cosine")
)
#> [1] TRUE
```

We then upload our data to the collection

``` r
upload_points(r_qdrant, "top_wines", encoded_data)
```

And now we can search our collection using the encoded prompt!

``` r
search(r_qdrant, "top_wines", encoded_prompt, limit=3L)
#> [[1]]
#> ScoredPoint(id=616, version=0, score=0.5854496082940178, payload={'name': 'Catena Zapata Nicasia Vineyard Malbec 2004', 'region': 'Argentina', 'variety': 'Red Wine', 'rating': 96.0, 'notes': '"The single-vineyard 2004 Malbec Nicasia Vineyard is located in the Altamira district of Mendoza. It was aged for 18 months in new French oak. Opaque purple-colored, it exhibits a complex perfume of pain grille, scorched earth, mineral, licorice, blueberry, and black cherry. Thick on the palate, bordering on opulent, it has layers of fruit, silky tannins, and a long, fruit-filled finish. It will age effortlessly for another 6-8 years and provide pleasure through 2025. When all is said and done, Catena Zapata is the Argentina winery of reference – the standard of excellence for comparing all others. The brilliant, forward-thinking Nicolas Catena remains in charge, with his daughter, Laura, playing an increasingly large role. The Catena Zapata winery is an essential destination for fans of both architecture and wine in Mendoza. It is hard to believe, given the surge in popularity of Malbec in recent years, that Catena Zapata only began exporting Malbec to the United States in 1994."'}, vector=None, shard_key=None, order_value=None)
#> 
#> [[2]]
#> ScoredPoint(id=253, version=0, score=0.5812595954872024, payload={'name': 'Catena Zapata Argentino Vineyard Malbec 2004', 'region': 'Argentina', 'variety': 'Red Wine', 'rating': 98.0, 'notes': '"The single-vineyard 2004 Malbec Argentino Vineyard spent 17 months in new French oak. Remarkably fragrant and complex aromatically, it offers up aromas of wood smoke, creosote, pepper, clove, black cherry, and blackberry. Made in a similar, elegant style, it is the most structured of the three single vineyard wines, needing a minimum of a decade of additional cellaring. It should easily prove to be a 25-40 year wine. It is an exceptional achievement in Malbec. When all is said and done, Catena Zapata is the Argentina winery of reference – the standard of excellence for comparing all others. The brilliant, forward-thinking Nicolas Catena remains in charge, with his daughter, Laura, playing an increasingly large role. The Catena Zapata winery is an essential destination for fans of both architecture and wine in Mendoza. It is hard to believe, given the surge in popularity of Malbec in recent years, that Catena Zapata only began exporting Malbec to the United States in 1994."'}, vector=None, shard_key=None, order_value=None)
#> 
#> [[3]]
#> ScoredPoint(id=627, version=0, score=0.5706620284928631, payload={'name': "Brovia Ca'Mia Barolo 2008", 'region': 'Barolo, Piedmont, Italy', 'variety': 'Red Wine', 'rating': 96.0, 'notes': 'We often call this cru "Il Ruffiano" for its rustic, raffish nature.  This is a boisterous, friendly Barolo from the heart of Serralunga d\'Alba with all that zone\'s lush fruit and generous body.  Here the wine thrusts us into the dense ambience of the forest: the dark berry-like fruit, the moss and underbrush, the truffles and mushrooms of the Langhe.  It\'s all there with bravado and confidence.  Warm, rich, dense … one of our best friends at the table.'}, vector=None, shard_key=None, order_value=None)
```
