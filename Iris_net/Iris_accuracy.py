import numpy as np
import pandas as pd
from sklearn.datasets import load_iris
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.metrics import accuracy_score, classification_report


df = pd.read_csv("C:/Users/User/Documents/Iris_net/results.log", sep="=", names=["label", "Yc"])
Yc = df["Yc"].to_list()

iris = load_iris()
X = iris.data
y = iris.target.reshape(-1, 1) 

encoder = OneHotEncoder(sparse_output=False)
y_onehot = encoder.fit_transform(y).astype(int)

y_true = iris.target
y_pred = Yc

accuracy = accuracy_score(y_true, y_pred) * 100
#When quantized to a signed Q3.4 fixed-point representation, the Iris_net hardware model reached an accuracy of 97.33% based on weights from a specific training instance.
print(f"Iris_net accuracy score: {accuracy:.2f}%")
