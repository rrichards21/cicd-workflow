torchserve --start --model-store model_store --models doubleit_model.mar --ts-config config/config.properties

torch-model-archiver --model-name doubleit_model --version 1.0 --serialized-file src/doubleit_model.pt --handler src/model.py --export-path model_store --extra-files src/model.py -f