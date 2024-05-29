import tensorflow as tf

# Vérifiez la version de TensorFlow
print("TensorFlow version:", tf.__version__)

# Liste les GPU disponibles
gpus = tf.config.list_physical_devices('GPU')

if gpus:
    print(f"GPUs disponibles ({len(gpus)}):")
    for gpu in gpus:
        print(gpu)
else:
    print("Aucun GPU détecté")


import torch

# Vérifiez la version de PyTorch
print("PyTorch version:", torch.__version__)

# Vérifiez si CUDA est disponible
cuda_available = torch.cuda.is_available()
print("CUDA available:", cuda_available)

# Liste les GPU disponibles
if cuda_available:
    num_gpus = torch.cuda.device_count()
    print(f"Number of GPUs: {num_gpus}")
    for i in range(num_gpus):
        print(f"GPU {i}: {torch.cuda.get_device_name(i)}")
else:
    print("No GPU detected")
