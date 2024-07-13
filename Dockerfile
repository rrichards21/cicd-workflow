# Usa una imagen de Python 3.9 slim basada en Debian Buster
FROM python:3.9-slim-buster

# Instala OpenJDK 11 desde los repositorios de Debian
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    openjdk-11-jdk-headless \
    && apt-get clean

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Instala Poetry
RUN pip install poetry

# Copia los archivos del proyecto
COPY pyproject.toml poetry.lock* ./
RUN poetry install --no-root

# Copia el resto de los archivos del proyecto
COPY . .

# Exponer puertos
EXPOSE 8080 8081

# Comando para iniciar TorchServe
CMD ["poetry", "run", "torchserve", "--start", "--model-store", "model_store", "--models", "doubleit_model.mar", "--ts-config", "config/config.properties"]
