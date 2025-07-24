# SystemVerilog-Neural-Networks

Basic implementations of a neuron and two neural network architectures in SystemVerilog, featuring a layer-level pipeline for high-throughput inference.

### Modules
.
* **`neuron_template_sigmoid.sv`**: A template for a Perceptron-type neuron with a sigmoid activation function. It demonstrates the fundamental structure of a neuron, which can be adapted for other activation functions (like ReLU, used in the `IRIS_net`)

* **`XOR_net`**: A Multi-Layer Perceptron (MLP) example that solves the non-linearly separable XOR problem. 

* **`Iris_net`**: A neural network designed to classify samples from the classic Iris flower dataset.

---

### A Note on Code Generation

The neural network examples (`XOR_net` and `IRIS_net`) were **automatically generated** by a custom tool. This tool converts a TensorFlow/Keras model into an equivalent SystemVerilog implementation, using `neuron_template` as a template.

This repository focuses on the resulting SystemVerilog code. The generator tool is not part of this project.
