FROM python:3.9-slim

WORKDIR /app

# Instalar poetry
RUN pip install poetry

# Copiar archivos de configuración de poetry
COPY pyproject.toml poetry.lock ./

# Instalar dependencias
RUN poetry config virtualenvs.create false \
  && poetry install --no-dev --no-interaction --no-ansi

COPY src/ .

CMD ["python", "inference.py"]