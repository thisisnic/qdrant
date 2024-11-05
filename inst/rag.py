import pandas as pd
from qdrant_client import models, QdrantClient
from sentence_transformers import SentenceTransformer

df = pd.read_csv('learn-retrieval-augmented-generation/top_rated_wines.csv')
df = df[df['variety'].notna()] # remove any NaN values as it blows up serialization
data = df.sample(700).to_dict('records') # Get only 700 records. More records will make it slower to index

encoder = SentenceTransformer('all-MiniLM-L6-v2') # Model to create embeddings
qdrant = QdrantClient(":memory:") # Create in-memory Qdrant instance
# Create collection to store wines
qdrant.recreate_collection(
    collection_name="top_wines",
    vectors_config=models.VectorParams(
        size=encoder.get_sentence_embedding_dimension(), # Vector size is defined by used model
        distance=models.Distance.COSINE
    )
)

# vectorize!
qdrant.upload_points(
    collection_name="top_wines",
    points=[
        models.PointStruct(
            id=idx,
            vector=encoder.encode(doc["notes"]).tolist(),
            payload=doc,
        ) for idx, doc in enumerate(data) # data is the variable holding all the wines
    ]
)

# Search time for awesome wines!

user_prompt = "A wine from Mendoza Argentina"

hits = qdrant.search(
    collection_name="top_wines",
    query_vector=encoder.encode(user_prompt).tolist(),
    limit=3
)
# for hit in hits:
#   print(hit.payload, "score:", hit.score)
  
search_results = [hit.payload for hit in hits]


