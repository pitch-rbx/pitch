# Python App Tests
This directory contains tests for the itch.io endpoints.

## Setup
With Python installed, install the dependencies:
```bash
python -m pip install -r requirements.txt
```

## Running
In the test app directory, run the following in a terminal:
```bash
uvicorn main:app --reload
```

After the app is started, open a browser to [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs).
Each of the endpoints has a "Try it out" button where you can
enter credentials to test.