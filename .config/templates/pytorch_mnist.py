from torchvision import datasets, transforms
import torch.utils.data

train_loader = torch.utils.data.DataLoader(
    datasets.MNIST(
	"/tmp/mnist_data", train=True, download=True, transform=transforms.Compose([
	    transforms.ToTensor(),
	])),batch_size=batch_size, shuffle=True)

test_loader = torch.utils.data.DataLoader(
    datasets.MNIST(
	"/tmp/mnist_data", train=False, download=True, transform=transforms.Compose([
	    transforms.ToTensor()
	])),batch_size=batch_size, shuffle=True)
