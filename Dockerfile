# Usa una imagen de Python 3.9 slim como imagen base
FROM python:3.9-slim

# Instala el gestor de paquetes necesarios
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    gnupg \
    && apt-get clean

# Configura el repositorio de OpenJDK 11
RUN mkdir -p /usr/share/man/man1 && \
    echo "deb http://deb.debian.org/debian stretch-backports main" | tee /etc/apt/sources.list.d/stretch-backports.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends openjdk-11-jdk-headless && \
    apt-get clean

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
