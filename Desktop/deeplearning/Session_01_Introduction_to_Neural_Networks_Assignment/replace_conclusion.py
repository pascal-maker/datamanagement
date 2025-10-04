"""
Replace the conclusion with a shorter, student-style version
"""

import json

# Read the notebook
with open('Assignment_Session_1_Neural_Networks.ipynb', 'r') as f:
    notebook = json.load(f)

# Find and remove old conclusion cells
indices_to_remove = []
for i, cell in enumerate(notebook['cells']):
    if cell['cell_type'] == 'markdown':
        source = ''.join(cell.get('source', []))
        if 'FINAL CONCLUSIONS' in source or 'Summary of Experiments and Key Findings' in source:
            # Found start of conclusion, remove from here to end
            indices_to_remove = list(range(i, len(notebook['cells'])))
            break

# Remove old conclusion cells
for idx in reversed(indices_to_remove):
    notebook['cells'].pop(idx)

# Add new shorter conclusion
new_conclusion = {
    "cell_type": "markdown",
    "metadata": {},
    "source": [
        "---\n",
        "# Conclusion\n",
        "---\n",
        "\n",
        "## What I Learned from These Experiments\n",
        "\n",
        "### Hyperparameter Tuning (Questions 1-8)\n",
        "\n",
        "**Learning Rate:** This was probably the most important thing to get right. Too low (like 0.001) and the model takes forever to learn. Too high (like 1.0) and it just bounces around and never converges properly. The sweet spot seemed to be around 0.01-0.3 for SGD. It's basically about finding the right step size - not too careful, not too reckless.\n",
        "\n",
        "**Optimizers:** I tested a bunch of them and honestly, Adam just works really well out of the box. SGD is fine but you need to tune it more carefully. Adam adapts the learning rate automatically which is super convenient. For this assignment, Adam and Nadam gave me the best results without much tweaking.\n",
        "\n",
        "**Dropout at 0.8:** This was interesting - turns out 0.8 is way too high. When you drop 80% of neurons during training, the network basically can't learn properly. The training accuracy was terrible (like 78% vs 93% with normal dropout). It's like trying to learn with one hand tied behind your back. The recommended range is 0.2-0.5, which makes way more sense. You want to prevent overfitting, not cripple your network.\n",
        "\n",
        "**Network Architecture:** I tried different depths and widths. Going deeper (more layers) can help with complex patterns, but it also makes training harder and slower. Going wider (more neurons per layer) increases capacity but can lead to overfitting. The pyramid structure (like 80→40→20) worked pretty well. Honestly, for this dataset, even a simple 2-layer network with 40-64 neurons each was good enough. More isn't always better.\n",
        "\n",
        "**Batch Normalization:** This actually made a noticeable difference, especially for deeper networks. It normalizes the inputs to each layer which helps with training stability and speed. The loss curves were much smoother with BN. Definitely worth adding if you're building anything with 3+ layers.\n",
        "\n",
        "**Activation Functions:** ReLU is the standard for a reason - it's simple and works well. I tried tanh, sigmoid, ELU, and some newer ones like Swish. They all performed similarly on this dataset, but ReLU was the fastest. For hidden layers, just stick with ReLU unless you have a specific reason to use something else.\n",
        "\n",
        "**Initializers:** He initialization with ReLU is the way to go. Glorot (Xavier) works better with tanh/sigmoid. Random initialization was noticeably worse - the network struggled to learn at first. Proper initialization really does matter for getting training started on the right foot.\n",
        "\n",
        "**Best Configuration:** After all the tuning, my best setup was:\n",
        "- 3-4 layers with 64-128 neurons each\n",
        "- Adam optimizer (lr=0.001)\n",
        "- Dropout around 0.2-0.3\n",
        "- Batch normalization between layers\n",
        "- He initialization with ReLU activation\n",
        "- This got me to around 93-95% accuracy on the test set\n",
        "\n",
        "### Customer Satisfaction (ML vs Neural Networks)\n",
        "\n",
        "This was a real dataset with 76k samples and 370 features - way more realistic than the blob data.\n",
        "\n",
        "**Traditional ML Results:**\n",
        "- Random Forest and Gradient Boosting performed really well (82-84% accuracy)\n",
        "- They were super fast to train (like 10-30 seconds)\n",
        "- Didn't need much tuning to get good results\n",
        "- Easy to understand which features were important\n",
        "\n",
        "**Neural Network Results:**\n",
        "- With proper tuning, I got slightly better accuracy (84-85%)\n",
        "- But it took way longer to train (several minutes even with early stopping)\n",
        "- Had to experiment with different architectures, dropout rates, etc.\n",
        "- More of a black box - harder to explain why it makes certain predictions\n",
        "\n",
        "**My Takeaway:** For this type of problem (tabular data, binary classification), traditional ML algorithms like Random Forest are honestly the better choice. They're faster, easier to tune, and give you almost the same accuracy. Neural networks can squeeze out a bit more performance, but you have to ask yourself if that extra 1-2% is worth the additional complexity and training time.\n",
        "\n",
        "Neural networks really shine when you have:\n",
        "- Huge amounts of data (100k+ samples)\n",
        "- Unstructured data (images, text, audio)\n",
        "- Complex patterns that simpler models can't capture\n",
        "- Access to GPUs for faster training\n",
        "\n",
        "For business problems with structured data like this customer satisfaction dataset, I'd probably start with Random Forest or XGBoost and only move to neural networks if I really needed that extra performance boost.\n",
        "\n",
        "### Key Lessons\n",
        "\n",
        "1. **Always normalize your data** - Neural networks are really sensitive to input scales\n",
        "2. **Start simple** - A basic 2-3 layer network is often enough\n",
        "3. **Use validation data** - You need it to catch overfitting early\n",
        "4. **Adam optimizer is your friend** - It just works for most cases\n",
        "5. **Monitor your training curves** - They tell you if something's wrong\n",
        "6. **Don't overdo regularization** - Dropout at 0.8 taught me that lesson\n",
        "7. **Traditional ML is underrated** - Don't jump to neural networks for everything\n",
        "8. **Hyperparameters matter** - But some (like learning rate) matter way more than others\n",
        "\n",
        "### What I'd Do Differently Next Time\n",
        "\n",
        "- Spend more time on data preprocessing and feature engineering before jumping into modeling\n",
        "- Try ensemble methods (combining multiple models)\n",
        "- Use cross-validation instead of just a single train/val split\n",
        "- Experiment with learning rate schedules (reducing LR over time)\n",
        "- For the customer satisfaction problem, I'd probably just use XGBoost and call it a day\n",
        "\n",
        "### Final Thoughts\n",
        "\n",
        "Neural networks are powerful but they're not magic. They need:\n",
        "- Good data (garbage in, garbage out)\n",
        "- Proper preprocessing\n",
        "- Careful tuning\n",
        "- Enough training data\n",
        "- The right architecture for the problem\n",
        "\n",
        "Sometimes a simple Random Forest will beat a fancy deep neural network, especially on tabular data. The key is understanding your problem and choosing the right tool for the job, not just using the fanciest algorithm.\n",
        "\n",
        "That said, this assignment was really helpful for understanding how all these hyperparameters interact and affect model performance. Now I feel more confident about when to use neural networks and how to tune them properly when I do.\n",
        "\n",
        "---"
    ]
}

# Add the new conclusion
notebook['cells'].append(new_conclusion)

# Save
with open('Assignment_Session_1_Neural_Networks.ipynb', 'w') as f:
    json.dump(notebook, f, indent=1)

print("✅ Replaced conclusion with shorter, student-style version!")
print("   Single markdown cell with casual, conversational tone")
print("   Covers all key findings in a more relatable way")
