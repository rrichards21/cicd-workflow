import torch
from src.inference import load_model, predict

def test_model_output():
    model = load_model('./src/doubleit-model.pt')
    sample_tensor = torch.tensor([1, 2, 3, 4])
    result = predict(model, sample_tensor)
    expected = torch.tensor([2, 4, 6, 8])
    assert torch.all(torch.eq(result, expected))