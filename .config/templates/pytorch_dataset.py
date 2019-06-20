import torch
import torch.utils.data

class <++>(torch.utils.data.Dataset):
    def __init__(self, loc, train=True, transform=None):
        super(<++>, self).__init__()
        self.location = loc if loc[-1] == "/" else loc+"/"
        self.transform = transform
        #TODO: load data

    def __getitem__(self, index):
        #TODO: get input and label
        if self.transform is not None:
            input = self.transform(input)
        
        return input, label

    def __len__(self):
        return len(self.data)
