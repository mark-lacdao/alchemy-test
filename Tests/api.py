from jsonschema import validate
import requests
import json

api_source = "https://jsonplaceholder.typicode.com/users"

response = requests.get(api_source)

content = json.loads(response.content)

def test_status_code():
    assert(response.status_code == 200)