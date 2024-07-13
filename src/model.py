import torch
import json
from ts.torch_handler.base_handler import BaseHandler

class DoubleItHandler(BaseHandler):
    def initialize(self, context):
        self.model = torch.jit.load(context.system_properties.get("model_dir") + "/doubleit_model.pt")

    def preprocess(self, data):
        # Convertir cuerpo JSON a lista de Python
        if isinstance(data, bytes):
            data_str = data.decode("utf-8")
            data = json.loads(data_str)

        # Extraer los datos numéricos del diccionario
        if isinstance(data, list) and len(data) > 0 and isinstance(data[0], dict):
            data = data[0].get('body', [])  # Extraer la clave 'body' del diccionario
        else:
            data = []

        return data

    def handle(self, data, context):
        try:
            # Preprocesar los datos de entrada
            print(f"Datos recibidos: {data}")
            data = self.preprocess(data)
            print(f"Datos preprocesados: {data}")

            # Convertir lista a tensor de Torch
            sample_tensor = torch.tensor(data, dtype=torch.float32).unsqueeze(0)  # Agregar dimensión de batch
            print(f"Tensor convertido: {sample_tensor}")

            # Realizar inferencia
            result = self.model(sample_tensor)

            # Preparar salida
            output = result.squeeze(0).tolist()  # Remover dimensión de batch y convertir a lista
            print(f"Salida: {output}")
            return [output]  # Devolver como una lista

        except Exception as e:
            print(f"Error durante la inferencia: {str(e)}")
            return [{"error": str(e)}]
