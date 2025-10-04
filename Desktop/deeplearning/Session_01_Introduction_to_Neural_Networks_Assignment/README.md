# Neural Networks Assignment - Session 01

This repository contains a comprehensive exploration of neural networks through three main assignments:

## 📚 Contents

### 1. Hyperparameter Experiments (Questions 1-8)
Systematic exploration of neural network hyperparameters on synthetic blob classification data:
- **Learning Rate Effects**: Testing different learning rates with SGD optimizer
- **Optimizer Comparison**: SGD, Adam, RMSprop, Adagrad, Nadam
- **Dropout Analysis**: Understanding the impact of dropout (including extreme case of 0.8)
- **Network Architecture**: Comparing different depths and widths
- **Batch Normalization**: Effects on training stability and convergence
- **Activation Functions**: ReLU, Tanh, Sigmoid, ELU, SELU, Swish, GELU
- **Weight Initializers**: Glorot, He, LeCun, Random
- **Hyperparameter Tuning**: Finding optimal configurations

### 2. Customer Satisfaction Prediction
Real-world binary classification problem comparing ML algorithms vs Neural Networks:
- **Dataset**: 76,020 samples with 370 features
- **Task**: Predict customer satisfaction (satisfied vs unsatisfied)
- **Approaches Tested**:
  - Traditional ML: Logistic Regression, Random Forest, Gradient Boosting, SVM, KNN, Naive Bayes
  - Neural Networks: Various architectures with hyperparameter tuning
- **Analysis**: Speed vs accuracy trade-offs, when to use ML vs NN

### 3. Fashion-MNIST Classification
Image classification task with 10 clothing categories:
- **Dataset**: 60,000 training images, 10,000 test images (28x28 grayscale)
- **Approaches**:
  - Fully Connected Network (raw pixels)
  - PCA + Neural Network (dimensionality reduction)
  - Convolutional Neural Network (CNN)
- **Analysis**: Misclassification visualization and explanation
- **Benchmark**: Comparison with official Fashion-MNIST leaderboard

## 🎯 Key Findings

### Hyperparameters
- **Learning Rate**: 0.01-0.3 optimal for SGD; too low = slow, too high = unstable
- **Best Optimizer**: Adam (adaptive learning rates, works well out-of-the-box)
- **Dropout**: 0.2-0.5 is ideal; 0.8 is too aggressive and causes underfitting
- **Batch Normalization**: Significantly improves training stability, especially for deep networks
- **Activation**: ReLU is solid default; modern activations (ELU, Swish) can improve performance
- **Initialization**: Use He with ReLU, Glorot with tanh

### ML vs Neural Networks
- **Traditional ML**: Faster training, less tuning, more interpretable, good for tabular data
- **Neural Networks**: Higher accuracy potential, better for complex patterns, requires more data/tuning
- **Recommendation**: Start with ensemble ML (Random Forest, XGBoost), use NN if marginal improvement is worth complexity

### Fashion-MNIST
- **CNN Performance**: ~91-93% accuracy (best approach for images)
- **Fully Connected**: ~88-89% accuracy
- **PCA**: Faster training but lower accuracy (~82-87%)
- **Common Misclassifications**: Shirt vs T-shirt, Coat vs Pullover (similar visual features)

## 📊 Results

All experiments include:
- Training curves (accuracy and loss)
- Comparison visualizations
- Performance metrics
- Detailed analysis and conclusions

## 🛠️ Technologies Used

- **Python 3.12**
- **TensorFlow/Keras**: Neural network implementation
- **Scikit-learn**: ML algorithms, preprocessing, metrics
- **Pandas & NumPy**: Data manipulation
- **Matplotlib & Seaborn**: Visualization

## 📝 Note on Data

The CSV datasets (`customersatisfaction.csv`, `fashion-mnist_train.csv`, `fashion-mnist_test.csv`) are not included in this repository due to their size. You can:
- Download Fashion-MNIST from: https://github.com/zalandoresearch/fashion-mnist
- Customer satisfaction dataset should be provided separately

## 🚀 Running the Notebook

1. Install dependencies:
```bash
pip install tensorflow scikit-learn pandas numpy matplotlib seaborn
```

2. Open the Jupyter notebook:
```bash
jupyter notebook Assignment_Session_1_Neural_Networks.ipynb
```

3. Run cells sequentially to reproduce all experiments

## 📈 Visualizations

The repository includes generated plots from experiments:
- Learning rate effects
- Optimizer comparisons
- Dropout analysis
- Architecture comparisons
- Batch normalization effects
- Activation function comparisons
- Weight initializer comparisons
- Final hyperparameter tuning results

## 👨‍🎓 Author

Pascal Musabyimana

## 📄 License

This is an educational project for a Deep Learning course.
