from jsonschema import validate
import requests
import json

api_source = "https://jsonplaceholder.typicode.com/users"

response = requests.get(api_source)

content = json.loads(response.content)
