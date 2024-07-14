
# Modelo en Producción con Google Cloud Platform

## Requisitos
- Docker
- Terraform
- Google Cloud SDK
- Poetry
- TorchServe

## Configuración
1. Clonar el repositorio:
    ```sh
    git clone <repo-url>
    cd <repo-name>
    ```

2. Instalar las dependencias con Poetry:
    ```sh
    poetry install
    ```

3. Empaquetar el modelo:
    ```sh
    poetry run torch-model-archiver --model-name doubleit_model --version 1.0 --serialized-file src/doubleit_model.pt --handler src/model.py --export-path model_store --extra-files src/model.py
    ```

4. Crear una imagen Docker:
    ```sh
    docker build -t my-model:latest .
    ```

5. Ejecutar los tests:
    ```sh
    docker run my-model:latest poetry run pytest
    ```

## Despliegue en GCP
1. Configurar Google Cloud SDK y autenticar:
    ```sh
    gcloud init
    gcloud auth application-default login
    ```

2. Desplegar la infraestructura con Terraform:
    ```sh
    cd terraform
    terraform init
    terraform apply
    ```

## CI/CD con GitHub Actions
La configuración del pipeline se encuentra en el archivo `.github/workflows/ci-cd.yml`. Este realiza los unit test, crea el container del proyecto y realiza el deploy a GCP.

## Uso de la API
1. Ejecutar la aplicación localmente:
    ```sh
    docker run -p 8080:8080 -p 8081:8081 my-model:latest
    ```

2. Realizar una petición de inferencia:
    ```sh
    curl -X POST http://localhost:8080/predictions/doubleit_model -H "Content-Type: application/json" -d '[1, 2, 3, 4]'
    ```
    (La API solo permite un input por request)