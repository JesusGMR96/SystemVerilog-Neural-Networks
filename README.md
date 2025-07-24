# SystemVerilog-Neural-Networks

Basic implementations of a neuron and two neural network architectures in SystemVerilog, featuring a layer-level pipeline for high-throughput inference.

### Modules

* **`neuron_model.sv`**: A fundamental Perceptron-type neuron model, which serves as the building block for the networks.

* **`XOR_net.sv`**: A Multi-Layer Perceptron (MLP) example that solves the non-linearly separable XOR problem. 

* **`IRIS_net.sv`**: A neural network designed to classify samples from the classic Iris flower dataset.

---

### A Note on Code Generation

The neural network examples (`XOR_net.sv` and `IRIS_net.sv`) were **automatically generated** by a custom tool. This tool converts a TensorFlow/Keras model into an equivalent SystemVerilog implementation, using `neuron_model.sv` as a template.

This repository focuses on the resulting SystemVerilog code. The generator tool is not part of this project.
