# Avicenna

[![Ruff](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/charliermarsh/ruff/main/assets/badge/v2.json)](https://github.com/astral-sh/ruff)

## Django backend

### How to use it?

1. Navigate into the *django_backend* folder.
2. Run the following one after another:

```python
python manage.py migrate
python manage.py runserver
```

3. Go to <http://127.0.0.1:8000/>

Note: make sure that you have Django installed. You may activate a venv using the dev-requirements.txt

#### Docker

You can also run it in a container.

1. Build the docker image with `docker build -t your_image_name .`
2. Run the built container with `docker run -p 8000:8000 your_image_name`

The API is going to be accessible at *<http://localhost:8000>*
