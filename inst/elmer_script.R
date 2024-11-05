reticulate::source_python("rag.py")

from openai import OpenAI
client = OpenAI(
  base_url="http://127.0.0.1:8080/v1", # "http://<Your api-server IP>:port"
  api_key = "sk-no-key-required"
)
completion = client.chat.completions.create(
  model="LLaMA_CPP",
  messages=[
    {"role": "system", "content": "You are chatbot, a wine specialist. Your top priority is to help guide users into selecting amazing wine and guide them with their requests."},
    {"role": "user", "content": "Suggest me an amazing Malbec wine from Argentina"},
    {"role": "assistant", "content": str(search_results)}
  ]
)
print(completion.choices[0].message)

library(elmer)

chat <- chat_openai(
  model = "gpt-4o-mini",
  system_prompt = "You are a friendly but terse assistant.",
  echo = TRUE
)

chat$chat("What preceding languages most influenced R?")

chat <- chat_openai(
  model = "gpt-4o-mini",
  turns = list(
    Turn(
      role = "system",
      contents = "You are chatbot, a wine specialist. Your top priority is to help guide users into selecting amazing wine and guide them with their requests."
    ),
    Turn(
      role = "user",
      contents = "Suggest me an amazing Malbec wine from Argentina"
    ),
    Turn(
      role = "assistant",
      contents = "",
      json = search_results
    )
  ),
  echo = TRUE
)

chat$chat("which wine?")
