from jsonschema import validate
import requests
import json

api_source = "https://jsonplaceholder.typicode.com/users"

response = requests.get(api_source)

content = json.loads(response.content)

json_schema_file = "api.schema.json"

schema = {}
with open(json_schema_file, 'r') as schema_file:
    schema = json.loads(schema_file.read())

def test_validity():
    validate(instance=content, schema=schema)

def test_status_code():
    assert(response.status_code == 200)