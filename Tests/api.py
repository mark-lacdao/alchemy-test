from jsonschema import validate
import requests
import json

api_source = "https://jsonplaceholder.typicode.com/users"
api_post = "https://jsonplaceholder.typicode.com/posts"

json_schema_file = "api.schema.json"
test_username = "Kamren"

response = requests.get(api_source)

content = json.loads(response.content)

schema = {}
with open(json_schema_file, 'r') as schema_file:
    schema = json.loads(schema_file.read())

def get_by_username(username):
    index = next(index for index, element in enumerate(content)
            if element["username"] == username)
    return content[index]

def test_validity():
    validate(instance=content, schema=schema)

def test_get_status_code():
    assert(response.status_code == 200)

def test_user_city():
    user = get_by_username(test_username)
    city = user["address"]["city"]
    assert(city == "Roscoeview")

def test_post():
    id_key = "id"
    user = get_by_username(test_username)
    identity = user[id_key]
    post_response = requests.post(api_post, json={id_key: identity})
    assert(post_response.status_code == 201)
    post_content = json.loads(post_response.content)
    assert(post_content[id_key] == 101)