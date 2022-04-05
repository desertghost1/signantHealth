import os
import tempfile
import json
import base64

import pytest

from demo_app import create_app
from demo_app.db import init_db

REGISTRATION_DATA = {
    "Username": "qaengineer",
    "Password": "testing",
    "First name": "QA",
    'Last name': "Engineer",
    "Phone number": "12345"
}

@pytest.fixture
def client():
    # Make temporary file
    db_fd, db_path = tempfile.mkstemp()
    app = create_app({
        'TESTING': True,
        'DATABASE': db_path
    })

    # create test client
    with app.test_client() as client:
        with app.app_context():
            init_db()
        yield client

    # release unneeded resource to prevent memory leak
    os.close(db_fd)
    os.unlink(db_path)

def setUp(client):
    # prepare and run the following for every test
    headers = {
        'Content-Type':
        'application/json'
    }

    user_endpoint = '/api/users'

    # make a post request to create new user
    response = client.post(user_endpoint, json=REGISTRATION_DATA, headers=headers)
    assert response.status_code == 201

def get_user_token(client, username, password):
    auth_string = "{}:{}".format(username, password)
    credentials = base64.b64encode(f'{auth_string}'.encode()).decode('utf-8')
    token_endpoint = "/api/auth/token"

    # create header with BASIC Authentication
    headers = {
        "Authorization": f"Basic {credentials}",
        "Content-Type":"application/json"
    }

    # make get request to extract token
    response = client.get(token_endpoint, headers=headers)
    assert response.status_code == 200 # (OK)

    # Extract token from response
    data=json.loads(response.data)
    token = data['token']
    return token

def test_add_user(client):
    setUp(client)

def test_get_all_users(client):
    setUp(client)
    username = REGISTRATION_DATA['username']
    password = REGISTRATION_DATA['password']
    user_endpoint = '/api/users'

    headers = {
        "Token": f"{token}",
        "Content-Type": "application/json"
    }

    # gte token from the get_user_token function
    token = get_user_token(client, username, password)
    response = client.get(user_endpoint, headers=headers)
    assert response.status_code == 200

    # check if payload is in response
    assert b'payload' in response.data
    # convert response to dictionary
    data = json.loads(response.data)

    # check if payload contains data
    assert len(data['payload']) == 1

    # check if first item in payload is the username we passed to the initial request above
    assert data['payload'][0] == username

def test_get_user_info(client):
    setUp(client)

    username = REGISTRATION_DATA['username']
    password = REGISTRATION_DATA['password']
    username_endpoint = f"/api/users/{username}"
    headers = {
        "Token": f"{token}",
        "Content-Type":"application/json"
    }

    token = get_user_token(client, username, password)

    response = client.get(username_endpoint, headers=headers)
    assert response.status_code == 200

def test_update_user_info(client):
    setUp(client)
    username = REGISTRATION_DATA['username']
    password = REGISTRATION_DATA['password']
    username_endpoint = f"/api/users/{username}"

    token = get_user_token(client,username, password)
    headers = {
        "Token": "{token}",
        "Content-Type":"application/json"
    }

    # update user first name
    response = client.put(username_endpoint, json=dict(firstname="QA2"), headers=headers)
    assert response.status_code == 201
