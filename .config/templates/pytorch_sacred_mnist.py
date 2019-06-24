import sys, os
import torch
from torchvision import datasets, transforms
from sacred import Experiment
from sacred.observers import MongoObserver
import random
import torch.nn.functional as F
import numpy as np

class MovingAverage:
    def __init__(self, window_size):
        self.i = 0
        self.window_size = window_size

        self.reset()

    def add(self, n):
        self.window[self.i] = n
        self.i = (self.i + 1) % self.window_size
        self.valid_size = self.valid_size + 1 if self.valid_size < self.window_size else self.valid_size
        return self

    def __add__(self, n):
        return self.add(n)

    def get(self):
        if self.valid_size == 0:
            return 0.0
        return self.window[0:self.valid_size].sum() / self.window[0:self.valid_size].size

    def __float__(self):
        return self.get()
    
    def reset(self):
        self.window = np.zeros(self.window_size)
        self.valid_size = 0


ex = Experiment('exp')
        

@ex.config
def config():
    epochs = 10
    lr = 0.001

    batch_size = 256
    n_inputs = 28*28
    n_hidden = 300
    n_outputs = 10    

    avg_window = 100
    use_mongo = False
    if use_mongo:
        ex.observers.append(MongoObserver.create())
    
    device_name = None
    if device_name is not None:    
        device = torch.device(device_name)
    else:
        device = torch.device("cuda") if torch.cuda.is_available() else torch.device("cpu")

@ex.capture
def preProcess(x, device):
    return x.view(-1, 28*28).to(device)



@ex.capture
def init_loaders(batch_size):
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
 
    return (train_loader, test_loader)


@ex.capture
def getNet(n_inputs, n_hidden, n_outputs, device):
    return torch.nn.Sequential(
        torch.nn.Linear(n_inputs, n_hidden),
        torch.nn.LeakyReLU(),
        torch.nn.Linear(n_hidden, n_hidden),
        torch.nn.LeakyReLU(),
        torch.nn.Linear(n_hidden, n_outputs),
        torch.nn.Softmax(dim=1)
    ).to(device)

    
@ex.capture
def train(net, train_loader, lr, epochs, avg_window, batch_size, device, _run):
    optimizer = torch.optim.Adam(net.parameters(), lr = lr)
    
    loss_fn = torch.nn.CrossEntropyLoss()

    avg_loss = MovingAverage(avg_window)
    avg_accuracy = MovingAverage(avg_window)
    
    for epoch in range(0, epochs):
        for batch_num, (batch_X, batch_Y) in enumerate(train_loader):
            batch_X = preProcess(batch_X)

            out = net(batch_X)

            loss = loss_fn(out, batch_Y.to(device).type(torch.long).to(out.device))            
            _, preds = out.max(1)
            acc = (preds == batch_Y.to(device)).float().mean()

            print("epoch: %d perc: %.2f accuracy: %.4f loss: %.4f" % (epoch, batch_num/len(train_loader), acc.item(), loss.item()))

            optimizer.zero_grad()
            loss.backward()
            optimizer.step()

            avg_loss += loss.item()
            avg_accuracy += acc.item()

            _run.log_scalar("loss", float(avg_loss))
            _run.log_scalar("accuracy", float(avg_accuracy))


@ex.capture
def test(net, test_loader, batch_size, device):
    net.eval()
    trues = torch.tensor([])
    preds = torch.tensor([])
    for batch_X, batch_Y in test_loader:
        batch_X = preProcess(batch_X)

        out = net(batch_X)

        pred = out.max(1)[1].float().cpu()
        preds = torch.cat((preds, pred))
        trues = torch.cat((trues, batch_Y.float().cpu()))

    from sklearn.metrics import confusion_matrix, accuracy_score
    cm = confusion_matrix(trues.numpy(), preds.numpy())
    acc = accuracy_score(trues.numpy(), preds.numpy())
    print(cm)
    return acc


@ex.automain
def main():
    train_loader, test_loader = init_loaders()
    net = getNet()
    train(net, train_loader)
    acc = test(net, test_loader)
    print("accuracy: ", acc)
    #import pickle
    #pickle.dump(net, open("results/exp_"+str(acc), "wb"))
    return acc