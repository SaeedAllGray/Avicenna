FROM python:3.12-bookworm

WORKDIR /app

COPY requirements/requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt gunicorn

COPY . /app/
RUN python -m compileall -q /app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN python manage.py collectstatic --noinput

CMD ["gunicorn", "avicenna_backend.wsgi:application", "--bind", "0.0.0.0:8000"]
