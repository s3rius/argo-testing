FROM python:3.12.0-slim-bullseye

WORKDIR /app
RUN pip install poetry

COPY poetry.lock pyproject.toml /app/

RUN poetry install

COPY . /app

RUN poetry install

CMD [ "python", "-m", "argo_testing"]