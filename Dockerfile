FROM python:3.11-slim-bullseye

WORKDIR /app
RUN pip install poetry
RUN poetry config virtualenvs.create false

COPY poetry.lock pyproject.toml /app/

RUN poetry install

COPY . /app

RUN poetry install

CMD [ "python", "-m", "argo_testing"]