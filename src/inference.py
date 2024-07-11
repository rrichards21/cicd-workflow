import torch

def load_model(model_path: str) -> torch.jit.ScriptModule:
    """
    Load a PyTorch JIT compiled model.

    Args:
        model_path (str): Path to the .pt model file.

    Returns:
        torch.jit.ScriptModule: Loaded PyTorch model.
    """
    return torch.jit.load(model_path)

def predict(model: torch.jit.ScriptModule, input_tensor: torch.Tensor) -> torch.Tensor:
    """
    Make a prediction using the loaded model.

    Args:
        model (torch.jit.ScriptModule): Loaded PyTorch model.
        input_tensor (torch.Tensor): Input tensor for prediction.

    Returns:
        torch.Tensor: Prediction result.
    """
    return model(input_tensor)

if __name__ == "__main__":
    # Load the model
    ts = load_model('./doubleit_model.pt')

    # Example of inference
    sample_tensor = torch.tensor([1, 2, 3, 4])
    result = predict(ts, sample_tensor)
    print(result)  # <- tensor([2, 4, 6, 8])