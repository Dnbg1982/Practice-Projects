# Dog Detection Using Neural Networks
Handle unstructured data such as photos is possible using neural networks. In this project tensorflow library was used to build a model which detects breeds of dogs.

GOAL
--------------------------------------------------------------------------------------------------------------------------------
Identifying the breed of a dog given an image of a dog.

DATA
--------------------------------------------------------------------------------------------------------------------------------
Dataset used came from Kaggle dog breed identification competition.

EVALUATION
---------------------------------------------------------------------------------------------------------------------------------
The evaluation is a file with prediction probabilities from each dog breed of each test image.
- 120 breed of dogs.
- 10K images in the training set and about the same in test set as well.

MODEL BREAKDOWN
---------------------------------------------------------------------------------------------------------------------------------
1. Prepare data transforming into tensors.
2. Map images with labels.
3. Preprocessing Images (Turning Images into Tensors)
    - Take an image filepath as imput
    - Use Tensor to read the file and save it to a variable, 'image'
    - Turn our 'image (a jpg) into Tensors
    - Normalize image (convert from 0-255 to 0-1)
    - Resize the 'image' to be a shape of (224, 224)
    - Return the modify 'images'
4. Turning our data into batches
5.  Create callbacks
6.  Train the model
7.  Making and evaluating prediction with probailities.


![image](https://user-images.githubusercontent.com/100526221/208555270-e9a9bab0-d47d-44f6-a079-a66e6d52c110.png)
