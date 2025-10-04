"""
Comprehensive Neural Network Hyperparameter Experiments
This script systematically explores various hyperparameters and their effects
"""

import numpy as np
import matplotlib.pyplot as plt
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Dropout, BatchNormalization
from sklearn.model_selection import train_test_split
from sklearn.datasets import make_blobs
from sklearn.preprocessing import StandardScaler
import pandas as pd

# Generate dataset
X, y = make_blobs(n_samples=1000, centers=4, center_box=(-10, 10),
                 random_state=0, cluster_std=1)

# Prepare data
from tensorflow.keras.utils import to_categorical
y_categorical = to_categorical(y)
X_train, X_test, y_train, y_test = train_test_split(X, y_categorical, test_size=0.2, random_state=42)

# Standardize features
scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_test = scaler.transform(X_test)

input_dim = X_train.shape[1]
output_dim = y_train.shape[1]

# ============================================================================
# EXPERIMENT 1: Learning Rate Effects (SGD)
# ============================================================================
print("=" * 80)
print("EXPERIMENT 1: Learning Rate Effects with SGD")
print("=" * 80)

learning_rates = [0.001, 0.01, 0.1, 0.3, 1.0]
lr_results = {}

for lr in learning_rates:
    print(f"\nTesting learning rate: {lr}")
    
    model = Sequential([
        Dense(40, input_dim=input_dim, kernel_initializer='glorot_uniform', activation='relu'),
        Dense(40, kernel_initializer='glorot_uniform', activation='relu'),
        Dense(output_dim, kernel_initializer='glorot_uniform', activation='softmax')
    ])
    
    optimizer = tf.keras.optimizers.SGD(learning_rate=lr)
    model.compile(loss='categorical_crossentropy', optimizer=optimizer, metrics=['accuracy'])
    
    history = model.fit(X_train, y_train, validation_split=0.3, epochs=50, verbose=0)
    test_loss, test_acc = model.evaluate(X_test, y_test, verbose=0)
    
    lr_results[lr] = {
        'history': history.history,
        'test_accuracy': test_acc,
        'final_train_acc': history.history['accuracy'][-1],
        'final_val_acc': history.history['val_accuracy'][-1]
    }
    
    print(f"  Train Acc: {lr_results[lr]['final_train_acc']:.4f}")
    print(f"  Val Acc: {lr_results[lr]['final_val_acc']:.4f}")
    print(f"  Test Acc: {test_acc:.4f}")

# Plot learning curves for different learning rates
plt.figure(figsize=(15, 5))

plt.subplot(1, 2, 1)
for lr in learning_rates:
    plt.plot(lr_results[lr]['history']['accuracy'], label=f'LR={lr}')
plt.xlabel('Epoch')
plt.ylabel('Training Accuracy')
plt.title('Training Accuracy vs Learning Rate')
plt.legend()
plt.grid(True)

plt.subplot(1, 2, 2)
for lr in learning_rates:
    plt.plot(lr_results[lr]['history']['val_accuracy'], label=f'LR={lr}')
plt.xlabel('Epoch')
plt.ylabel('Validation Accuracy')
plt.title('Validation Accuracy vs Learning Rate')
plt.legend()
plt.grid(True)

plt.tight_layout()
plt.savefig('experiment1_learning_rates.png', dpi=300, bbox_inches='tight')
plt.show()

print("\n📊 CONCLUSIONS - Learning Rate:")
print("- Too low (0.001): Slow convergence, may need more epochs")
print("- Optimal range (0.01-0.3): Good balance between speed and stability")
print("- Too high (1.0): May overshoot optimal weights, unstable training")

# ============================================================================
# EXPERIMENT 2: Different Optimizers
# ============================================================================
print("\n" + "=" * 80)
print("EXPERIMENT 2: Comparing Different Optimizers")
print("=" * 80)

optimizers_config = {
    'SGD': tf.keras.optimizers.SGD(learning_rate=0.01),
    'SGD+Momentum': tf.keras.optimizers.SGD(learning_rate=0.01, momentum=0.9),
    'Adam': tf.keras.optimizers.Adam(learning_rate=0.001),
    'RMSprop': tf.keras.optimizers.RMSprop(learning_rate=0.001),
    'Adagrad': tf.keras.optimizers.Adagrad(learning_rate=0.01),
    'Adamax': tf.keras.optimizers.Adamax(learning_rate=0.002),
    'Nadam': tf.keras.optimizers.Nadam(learning_rate=0.001)
}

optimizer_results = {}

for opt_name, optimizer in optimizers_config.items():
    print(f"\nTesting optimizer: {opt_name}")
    
    model = Sequential([
        Dense(40, input_dim=input_dim, kernel_initializer='glorot_uniform', activation='relu'),
        Dense(40, kernel_initializer='glorot_uniform', activation='relu'),
        Dense(output_dim, kernel_initializer='glorot_uniform', activation='softmax')
    ])
    
    model.compile(loss='categorical_crossentropy', optimizer=optimizer, metrics=['accuracy'])
    history = model.fit(X_train, y_train, validation_split=0.3, epochs=50, verbose=0)
    test_loss, test_acc = model.evaluate(X_test, y_test, verbose=0)
    
    optimizer_results[opt_name] = {
        'history': history.history,
        'test_accuracy': test_acc,
        'final_train_acc': history.history['accuracy'][-1],
        'final_val_acc': history.history['val_accuracy'][-1]
    }
    
    print(f"  Train Acc: {optimizer_results[opt_name]['final_train_acc']:.4f}")
    print(f"  Val Acc: {optimizer_results[opt_name]['final_val_acc']:.4f}")
    print(f"  Test Acc: {test_acc:.4f}")

# Plot optimizer comparison
plt.figure(figsize=(15, 5))

plt.subplot(1, 2, 1)
for opt_name in optimizers_config.keys():
    plt.plot(optimizer_results[opt_name]['history']['loss'], label=opt_name)
plt.xlabel('Epoch')
plt.ylabel('Training Loss')
plt.title('Training Loss vs Optimizer')
plt.legend()
plt.grid(True)

plt.subplot(1, 2, 2)
for opt_name in optimizers_config.keys():
    plt.plot(optimizer_results[opt_name]['history']['val_accuracy'], label=opt_name)
plt.xlabel('Epoch')
plt.ylabel('Validation Accuracy')
plt.title('Validation Accuracy vs Optimizer')
plt.legend()
plt.grid(True)

plt.tight_layout()
plt.savefig('experiment2_optimizers.png', dpi=300, bbox_inches='tight')
plt.show()

print("\n📊 CONCLUSIONS - Optimizers:")
print("- SGD: Simple but requires careful learning rate tuning")
print("- SGD+Momentum: Faster convergence than vanilla SGD, smoother updates")
print("- Adam: Adaptive learning rates, generally fast and stable (often best default)")
print("- RMSprop: Good for RNNs, handles non-stationary objectives well")
print("- Adagrad: Adapts learning rate per parameter, good for sparse data")
print("- Adamax: Variant of Adam based on infinity norm, more stable in some cases")
print("- Nadam: Adam + Nesterov momentum, often slightly better than Adam")

# ============================================================================
# EXPERIMENT 3: Dropout Rate Effects
# ============================================================================
print("\n" + "=" * 80)
print("EXPERIMENT 3: Dropout Rate Effects")
print("=" * 80)

dropout_rates = [0.0, 0.2, 0.5, 0.8]
dropout_results = {}

for dropout in dropout_rates:
    print(f"\nTesting dropout rate: {dropout}")
    
    model = Sequential([
        Dense(40, input_dim=input_dim, kernel_initializer='glorot_uniform', activation='relu'),
        Dropout(dropout),
        Dense(40, kernel_initializer='glorot_uniform', activation='relu'),
        Dropout(dropout),
        Dense(output_dim, kernel_initializer='glorot_uniform', activation='softmax')
    ])
    
    optimizer = tf.keras.optimizers.Adam(learning_rate=0.001)
    model.compile(loss='categorical_crossentropy', optimizer=optimizer, metrics=['accuracy'])
    
    history = model.fit(X_train, y_train, validation_split=0.3, epochs=100, verbose=0)
    test_loss, test_acc = model.evaluate(X_test, y_test, verbose=0)
    
    dropout_results[dropout] = {
        'history': history.history,
        'test_accuracy': test_acc,
        'final_train_acc': history.history['accuracy'][-1],
        'final_val_acc': history.history['val_accuracy'][-1]
    }
    
    print(f"  Train Acc: {dropout_results[dropout]['final_train_acc']:.4f}")
    print(f"  Val Acc: {dropout_results[dropout]['final_val_acc']:.4f}")
    print(f"  Test Acc: {test_acc:.4f}")

# Plot dropout effects
plt.figure(figsize=(15, 5))

plt.subplot(1, 2, 1)
for dropout in dropout_rates:
    plt.plot(dropout_results[dropout]['history']['accuracy'], label=f'Dropout={dropout}')
plt.xlabel('Epoch')
plt.ylabel('Training Accuracy')
plt.title('Training Accuracy vs Dropout Rate')
plt.legend()
plt.grid(True)

plt.subplot(1, 2, 2)
for dropout in dropout_rates:
    plt.plot(dropout_results[dropout]['history']['val_accuracy'], label=f'Dropout={dropout}')
plt.xlabel('Epoch')
plt.ylabel('Validation Accuracy')
plt.title('Validation Accuracy vs Dropout Rate')
plt.legend()
plt.grid(True)

plt.tight_layout()
plt.savefig('experiment3_dropout.png', dpi=300, bbox_inches='tight')
plt.show()

print("\n📊 CONCLUSIONS - Dropout Rate 0.8:")
print("- With 0.8 dropout, 80% of neurons are randomly dropped during training")
print("- This is EXTREMELY high and severely limits the network's capacity")
print("- Training becomes very slow and may not converge properly")
print("- The network essentially trains with only 20% of its neurons at each step")
print("- Result: Poor performance, underfitting, large gap between train and val accuracy")
print("- Recommended: 0.2-0.5 for most cases, 0.0 if dataset is small or simple")

# ============================================================================
# EXPERIMENT 4: Network Architecture (Layers & Neurons)
# ============================================================================
print("\n" + "=" * 80)
print("EXPERIMENT 4: Network Architecture Effects")
print("=" * 80)

architectures = {
    'Small (2x20)': [20, 20],
    'Medium (2x40)': [40, 40],
    'Large (2x80)': [80, 80],
    'Deep (4x40)': [40, 40, 40, 40],
    'Very Deep (6x40)': [40, 40, 40, 40, 40, 40],
    'Wide Shallow (1x100)': [100],
    'Pyramid (80-40-20)': [80, 40, 20]
}

architecture_results = {}

for arch_name, layers in architectures.items():
    print(f"\nTesting architecture: {arch_name}")
    
    model = Sequential()
    model.add(Dense(layers[0], input_dim=input_dim, kernel_initializer='glorot_uniform', activation='relu'))
    
    for neurons in layers[1:]:
        model.add(Dense(neurons, kernel_initializer='glorot_uniform', activation='relu'))
    
    model.add(Dense(output_dim, kernel_initializer='glorot_uniform', activation='softmax'))
    
    optimizer = tf.keras.optimizers.Adam(learning_rate=0.001)
    model.compile(loss='categorical_crossentropy', optimizer=optimizer, metrics=['accuracy'])
    
    history = model.fit(X_train, y_train, validation_split=0.3, epochs=50, verbose=0)
    test_loss, test_acc = model.evaluate(X_test, y_test, verbose=0)
    
    total_params = model.count_params()
    
    architecture_results[arch_name] = {
        'history': history.history,
        'test_accuracy': test_acc,
        'final_train_acc': history.history['accuracy'][-1],
        'final_val_acc': history.history['val_accuracy'][-1],
        'total_params': total_params
    }
    
    print(f"  Parameters: {total_params}")
    print(f"  Train Acc: {architecture_results[arch_name]['final_train_acc']:.4f}")
    print(f"  Val Acc: {architecture_results[arch_name]['final_val_acc']:.4f}")
    print(f"  Test Acc: {test_acc:.4f}")

# Plot architecture comparison
plt.figure(figsize=(15, 10))

plt.subplot(2, 2, 1)
for arch_name in architectures.keys():
    plt.plot(architecture_results[arch_name]['history']['accuracy'], label=arch_name)
plt.xlabel('Epoch')
plt.ylabel('Training Accuracy')
plt.title('Training Accuracy vs Architecture')
plt.legend()
plt.grid(True)

plt.subplot(2, 2, 2)
for arch_name in architectures.keys():
    plt.plot(architecture_results[arch_name]['history']['val_accuracy'], label=arch_name)
plt.xlabel('Epoch')
plt.ylabel('Validation Accuracy')
plt.title('Validation Accuracy vs Architecture')
plt.legend()
plt.grid(True)

plt.subplot(2, 2, 3)
arch_names = list(architectures.keys())
test_accs = [architecture_results[name]['test_accuracy'] for name in arch_names]
plt.barh(arch_names, test_accs)
plt.xlabel('Test Accuracy')
plt.title('Test Accuracy by Architecture')
plt.grid(True, axis='x')

plt.subplot(2, 2, 4)
params = [architecture_results[name]['total_params'] for name in arch_names]
plt.barh(arch_names, params)
plt.xlabel('Number of Parameters')
plt.title('Model Complexity by Architecture')
plt.grid(True, axis='x')

plt.tight_layout()
plt.savefig('experiment4_architectures.png', dpi=300, bbox_inches='tight')
plt.show()

print("\n📊 CONCLUSIONS - Architecture:")
print("- Wider networks (more neurons): Better capacity but risk of overfitting")
print("- Deeper networks (more layers): Can learn more complex patterns")
print("- Too deep without proper techniques: Vanishing gradients, harder to train")
print("- Pyramid structure: Gradually reduces dimensions, often works well")
print("- Trade-off: Model complexity vs. generalization")

# ============================================================================
# EXPERIMENT 5: Batch Normalization Effects
# ============================================================================
print("\n" + "=" * 80)
print("EXPERIMENT 5: Batch Normalization Effects")
print("=" * 80)

bn_configs = {
    'No BN': False,
    'With BN': True
}

bn_results = {}

for config_name, use_bn in bn_configs.items():
    print(f"\nTesting configuration: {config_name}")
    
    model = Sequential()
    model.add(Dense(40, input_dim=input_dim, kernel_initializer='glorot_uniform', activation='relu'))
    if use_bn:
        model.add(BatchNormalization())
    
    model.add(Dense(40, kernel_initializer='glorot_uniform', activation='relu'))
    if use_bn:
        model.add(BatchNormalization())
    
    model.add(Dense(40, kernel_initializer='glorot_uniform', activation='relu'))
    if use_bn:
        model.add(BatchNormalization())
    
    model.add(Dense(output_dim, kernel_initializer='glorot_uniform', activation='softmax'))
    
    optimizer = tf.keras.optimizers.Adam(learning_rate=0.001)
    model.compile(loss='categorical_crossentropy', optimizer=optimizer, metrics=['accuracy'])
    
    history = model.fit(X_train, y_train, validation_split=0.3, epochs=50, verbose=0)
    test_loss, test_acc = model.evaluate(X_test, y_test, verbose=0)
    
    bn_results[config_name] = {
        'history': history.history,
        'test_accuracy': test_acc,
        'final_train_acc': history.history['accuracy'][-1],
        'final_val_acc': history.history['val_accuracy'][-1]
    }
    
    print(f"  Train Acc: {bn_results[config_name]['final_train_acc']:.4f}")
    print(f"  Val Acc: {bn_results[config_name]['final_val_acc']:.4f}")
    print(f"  Test Acc: {test_acc:.4f}")

# Plot batch normalization effects
plt.figure(figsize=(15, 5))

plt.subplot(1, 2, 1)
for config_name in bn_configs.keys():
    plt.plot(bn_results[config_name]['history']['loss'], label=config_name)
plt.xlabel('Epoch')
plt.ylabel('Training Loss')
plt.title('Training Loss: Batch Normalization Effect')
plt.legend()
plt.grid(True)

plt.subplot(1, 2, 2)
for config_name in bn_configs.keys():
    plt.plot(bn_results[config_name]['history']['val_accuracy'], label=config_name)
plt.xlabel('Epoch')
plt.ylabel('Validation Accuracy')
plt.title('Validation Accuracy: Batch Normalization Effect')
plt.legend()
plt.grid(True)

plt.tight_layout()
plt.savefig('experiment5_batch_normalization.png', dpi=300, bbox_inches='tight')
plt.show()

print("\n📊 CONCLUSIONS - Batch Normalization:")
print("- Normalizes inputs to each layer, reducing internal covariate shift")
print("- Benefits: Faster training, allows higher learning rates, acts as regularization")
print("- Especially useful for deep networks and when training is unstable")
print("- May add slight overhead but generally improves convergence")

# ============================================================================
# EXPERIMENT 6: Activation Functions
# ============================================================================
print("\n" + "=" * 80)
print("EXPERIMENT 6: Activation Function Effects")
print("=" * 80)

activations = ['relu', 'tanh', 'sigmoid', 'elu', 'selu', 'swish', 'gelu']
activation_results = {}

for activation in activations:
    print(f"\nTesting activation: {activation}")
    
    model = Sequential([
        Dense(40, input_dim=input_dim, kernel_initializer='glorot_uniform', activation=activation),
        Dense(40, kernel_initializer='glorot_uniform', activation=activation),
        Dense(output_dim, kernel_initializer='glorot_uniform', activation='softmax')
    ])
    
    optimizer = tf.keras.optimizers.Adam(learning_rate=0.001)
    model.compile(loss='categorical_crossentropy', optimizer=optimizer, metrics=['accuracy'])
    
    history = model.fit(X_train, y_train, validation_split=0.3, epochs=50, verbose=0)
    test_loss, test_acc = model.evaluate(X_test, y_test, verbose=0)
    
    activation_results[activation] = {
        'history': history.history,
        'test_accuracy': test_acc,
        'final_train_acc': history.history['accuracy'][-1],
        'final_val_acc': history.history['val_accuracy'][-1]
    }
    
    print(f"  Train Acc: {activation_results[activation]['final_train_acc']:.4f}")
    print(f"  Val Acc: {activation_results[activation]['final_val_acc']:.4f}")
    print(f"  Test Acc: {test_acc:.4f}")

# Plot activation function comparison
plt.figure(figsize=(15, 5))

plt.subplot(1, 2, 1)
for activation in activations:
    plt.plot(activation_results[activation]['history']['accuracy'], label=activation)
plt.xlabel('Epoch')
plt.ylabel('Training Accuracy')
plt.title('Training Accuracy vs Activation Function')
plt.legend()
plt.grid(True)

plt.subplot(1, 2, 2)
for activation in activations:
    plt.plot(activation_results[activation]['history']['val_accuracy'], label=activation)
plt.xlabel('Epoch')
plt.ylabel('Validation Accuracy')
plt.title('Validation Accuracy vs Activation Function')
plt.legend()
plt.grid(True)

plt.tight_layout()
plt.savefig('experiment6_activations.png', dpi=300, bbox_inches='tight')
plt.show()

print("\n📊 CONCLUSIONS - Activation Functions:")
print("- ReLU: Most common, fast, but can have 'dying ReLU' problem")
print("- Tanh: Zero-centered, but can saturate (vanishing gradients)")
print("- Sigmoid: Outputs [0,1], but saturates easily, rarely used in hidden layers")
print("- ELU: Smooth, can produce negative values, helps with vanishing gradients")
print("- SELU: Self-normalizing, works well with specific initialization")
print("- Swish/GELU: Modern activations, often perform better than ReLU")

# ============================================================================
# EXPERIMENT 7: Weight Initializers
# ============================================================================
print("\n" + "=" * 80)
print("EXPERIMENT 7: Weight Initializer Effects")
print("=" * 80)

initializers = {
    'glorot_uniform': 'glorot_uniform',
    'glorot_normal': 'glorot_normal',
    'he_uniform': 'he_uniform',
    'he_normal': 'he_normal',
    'random_uniform': 'random_uniform',
    'random_normal': 'random_normal',
    'lecun_uniform': 'lecun_uniform'
}

initializer_results = {}

for init_name, initializer in initializers.items():
    print(f"\nTesting initializer: {init_name}")
    
    model = Sequential([
        Dense(40, input_dim=input_dim, kernel_initializer=initializer, activation='relu'),
        Dense(40, kernel_initializer=initializer, activation='relu'),
        Dense(output_dim, kernel_initializer=initializer, activation='softmax')
    ])
    
    optimizer = tf.keras.optimizers.Adam(learning_rate=0.001)
    model.compile(loss='categorical_crossentropy', optimizer=optimizer, metrics=['accuracy'])
    
    history = model.fit(X_train, y_train, validation_split=0.3, epochs=50, verbose=0)
    test_loss, test_acc = model.evaluate(X_test, y_test, verbose=0)
    
    initializer_results[init_name] = {
        'history': history.history,
        'test_accuracy': test_acc,
        'final_train_acc': history.history['accuracy'][-1],
        'final_val_acc': history.history['val_accuracy'][-1]
    }
    
    print(f"  Train Acc: {initializer_results[init_name]['final_train_acc']:.4f}")
    print(f"  Val Acc: {initializer_results[init_name]['final_val_acc']:.4f}")
    print(f"  Test Acc: {test_acc:.4f}")

# Plot initializer comparison
plt.figure(figsize=(15, 5))

plt.subplot(1, 2, 1)
for init_name in initializers.keys():
    plt.plot(initializer_results[init_name]['history']['loss'], label=init_name)
plt.xlabel('Epoch')
plt.ylabel('Training Loss')
plt.title('Training Loss vs Initializer')
plt.legend()
plt.grid(True)

plt.subplot(1, 2, 2)
for init_name in initializers.keys():
    plt.plot(initializer_results[init_name]['history']['val_accuracy'], label=init_name)
plt.xlabel('Epoch')
plt.ylabel('Validation Accuracy')
plt.title('Validation Accuracy vs Initializer')
plt.legend()
plt.grid(True)

plt.tight_layout()
plt.savefig('experiment7_initializers.png', dpi=300, bbox_inches='tight')
plt.show()

print("\n📊 CONCLUSIONS - Initializers:")
print("- Glorot (Xavier): Good for tanh/sigmoid, maintains variance across layers")
print("- He: Designed for ReLU activations, accounts for ReLU's non-linearity")
print("- LeCun: Good for SELU activations")
print("- Random: Poor choice, can lead to vanishing/exploding gradients")
print("- Rule of thumb: Use He with ReLU, Glorot with tanh, LeCun with SELU")

# ============================================================================
# EXPERIMENT 8: Hyperparameter Tuning for Best Performance
# ============================================================================
print("\n" + "=" * 80)
print("EXPERIMENT 8: Hyperparameter Tuning for Optimal Performance")
print("=" * 80)

# Based on previous experiments, test promising combinations
tuning_configs = [
    {
        'name': 'Baseline',
        'layers': [40, 40],
        'activation': 'relu',
        'optimizer': tf.keras.optimizers.Adam(learning_rate=0.001),
        'dropout': 0.0,
        'batch_norm': False,
        'initializer': 'glorot_uniform'
    },
    {
        'name': 'Optimized_v1',
        'layers': [64, 64],
        'activation': 'relu',
        'optimizer': tf.keras.optimizers.Adam(learning_rate=0.001),
        'dropout': 0.2,
        'batch_norm': True,
        'initializer': 'he_uniform'
    },
    {
        'name': 'Optimized_v2',
        'layers': [80, 40, 20],
        'activation': 'elu',
        'optimizer': tf.keras.optimizers.Nadam(learning_rate=0.001),
        'dropout': 0.3,
        'batch_norm': True,
        'initializer': 'he_normal'
    },
    {
        'name': 'Optimized_v3',
        'layers': [100, 50],
        'activation': 'swish',
        'optimizer': tf.keras.optimizers.Adam(learning_rate=0.0005),
        'dropout': 0.25,
        'batch_norm': True,
        'initializer': 'he_uniform'
    },
    {
        'name': 'Deep_Network',
        'layers': [64, 64, 64, 32],
        'activation': 'relu',
        'optimizer': tf.keras.optimizers.Adam(learning_rate=0.001),
        'dropout': 0.2,
        'batch_norm': True,
        'initializer': 'he_uniform'
    }
]

tuning_results = {}

for config in tuning_configs:
    print(f"\nTesting configuration: {config['name']}")
    
    model = Sequential()
    
    # First layer
    model.add(Dense(config['layers'][0], input_dim=input_dim, 
                   kernel_initializer=config['initializer'], 
                   activation=config['activation']))
    if config['batch_norm']:
        model.add(BatchNormalization())
    if config['dropout'] > 0:
        model.add(Dropout(config['dropout']))
    
    # Hidden layers
    for neurons in config['layers'][1:]:
        model.add(Dense(neurons, kernel_initializer=config['initializer'], 
                       activation=config['activation']))
        if config['batch_norm']:
            model.add(BatchNormalization())
        if config['dropout'] > 0:
            model.add(Dropout(config['dropout']))
    
    # Output layer
    model.add(Dense(output_dim, kernel_initializer=config['initializer'], 
                   activation='softmax'))
    
    model.compile(loss='categorical_crossentropy', 
                 optimizer=config['optimizer'], 
                 metrics=['accuracy'])
    
    history = model.fit(X_train, y_train, validation_split=0.3, 
                       epochs=100, verbose=0, batch_size=32)
    
    test_loss, test_acc = model.evaluate(X_test, y_test, verbose=0)
    
    tuning_results[config['name']] = {
        'history': history.history,
        'test_accuracy': test_acc,
        'final_train_acc': history.history['accuracy'][-1],
        'final_val_acc': history.history['val_accuracy'][-1],
        'config': config
    }
    
    print(f"  Train Acc: {tuning_results[config['name']]['final_train_acc']:.4f}")
    print(f"  Val Acc: {tuning_results[config['name']]['final_val_acc']:.4f}")
    print(f"  Test Acc: {test_acc:.4f}")

# Plot final comparison
plt.figure(figsize=(15, 10))

plt.subplot(2, 2, 1)
for config_name in tuning_results.keys():
    plt.plot(tuning_results[config_name]['history']['accuracy'], label=config_name)
plt.xlabel('Epoch')
plt.ylabel('Training Accuracy')
plt.title('Training Accuracy - Final Comparison')
plt.legend()
plt.grid(True)

plt.subplot(2, 2, 2)
for config_name in tuning_results.keys():
    plt.plot(tuning_results[config_name]['history']['val_accuracy'], label=config_name)
plt.xlabel('Epoch')
plt.ylabel('Validation Accuracy')
plt.title('Validation Accuracy - Final Comparison')
plt.legend()
plt.grid(True)

plt.subplot(2, 2, 3)
config_names = list(tuning_results.keys())
test_accs = [tuning_results[name]['test_accuracy'] for name in config_names]
colors = ['red' if name == 'Baseline' else 'green' for name in config_names]
plt.barh(config_names, test_accs, color=colors)
plt.xlabel('Test Accuracy')
plt.title('Final Test Accuracy Comparison')
plt.grid(True, axis='x')

plt.subplot(2, 2, 4)
for config_name in tuning_results.keys():
    plt.plot(tuning_results[config_name]['history']['loss'], label=config_name)
plt.xlabel('Epoch')
plt.ylabel('Training Loss')
plt.title('Training Loss - Final Comparison')
plt.legend()
plt.grid(True)

plt.tight_layout()
plt.savefig('experiment8_hyperparameter_tuning.png', dpi=300, bbox_inches='tight')
plt.show()

# Find best configuration
best_config_name = max(tuning_results.keys(), 
                       key=lambda x: tuning_results[x]['test_accuracy'])
best_test_acc = tuning_results[best_config_name]['test_accuracy']

print("\n" + "=" * 80)
print("🏆 BEST CONFIGURATION")
print("=" * 80)
print(f"Configuration: {best_config_name}")
print(f"Test Accuracy: {best_test_acc:.4f}")
print(f"\nConfiguration Details:")
for key, value in tuning_results[best_config_name]['config'].items():
    if key != 'optimizer':
        print(f"  {key}: {value}")

print("\n📊 FINAL CONCLUSIONS:")
print("- Batch Normalization significantly improves training stability")
print("- Moderate dropout (0.2-0.3) helps prevent overfitting")
print("- He initialization works best with ReLU-family activations")
print("- Adam/Nadam optimizers generally outperform SGD")
print("- Architecture matters: balance between capacity and overfitting")
print("- Modern activations (ELU, Swish) can outperform ReLU")

# Create summary DataFrame
summary_data = []
for config_name, results in tuning_results.items():
    summary_data.append({
        'Configuration': config_name,
        'Train Accuracy': f"{results['final_train_acc']:.4f}",
        'Val Accuracy': f"{results['final_val_acc']:.4f}",
        'Test Accuracy': f"{results['test_accuracy']:.4f}",
        'Overfitting': f"{results['final_train_acc'] - results['final_val_acc']:.4f}"
    })

summary_df = pd.DataFrame(summary_data)
print("\n" + "=" * 80)
print("SUMMARY TABLE")
print("=" * 80)
print(summary_df.to_string(index=False))

print("\n✅ All experiments completed successfully!")
print("📁 Plots saved as PNG files in the current directory")
