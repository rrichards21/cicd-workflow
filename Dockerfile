FROM python:3.9-slim

WORKDIR /app

ENV JAVA_HOME C:/Program Files/Java/jdk-22
ENV PATH $JAVA_HOME/bin:$PATH

# Instalar Poetry
RUN pip install poetry

# Copiar archivos del proyecto
COPY pyproject.toml poetry.lock* ./
RUN poetry install --no-root

# Copiar archivos del proyecto
COPY . .

# Exponer puertos
EXPOSE 8080 8081

# Comando para iniciar TorchServe
CMD ["poetry", "run", "torchserve", "--start", "--model-store", "model_store", "--models", "doubleit_model.mar","--ts-config","config/config.properties"]
