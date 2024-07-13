# Usa una imagen de Python 3.9 slim como imagen base
FROM python:3.9-slim

# Instala OpenJDK 11
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk && \
    apt-get clean;

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
