"""
Fix the notebook by adding y_test conversion before experiments
"""

import json

# Read the notebook
with open('Assignment_Session_1_Neural_Networks.ipynb', 'r') as f:
    notebook = json.load(f)

# Find the first experiment cell (Question 1)
experiment_idx = None
for i, cell in enumerate(notebook['cells']):
    if cell['cell_type'] == 'markdown' and 'Question 1: Learning Rate Effects' in ''.join(cell['source']):
        experiment_idx = i
        break

if experiment_idx is None:
    print("Could not find experiment cells!")
    exit(1)

# Check if preparation cell already exists
prep_exists = False
if experiment_idx > 0:
    prev_cell = notebook['cells'][experiment_idx - 1]
    if prev_cell['cell_type'] == 'code' and 'y_test = to_categorical' in ''.join(prev_cell.get('source', [])):
        prep_exists = True
        print("Preparation cell already exists, skipping...")

if not prep_exists:
    # Add a preparation cell before the experiments
    prep_cell = {
        "cell_type": "code",
        "execution_count": None,
        "metadata": {},
        "outputs": [],
        "source": [
            "# Prepare data for experiments - convert y_test to categorical if not already done\n",
            "if len(y_test.shape) == 1 or y_test.shape[1] == 1:\n",
            "    y_test = to_categorical(y_test)\n",
            "    print(f\"Converted y_test to categorical. Shape: {y_test.shape}\")\n",
            "else:\n",
            "    print(f\"y_test already categorical. Shape: {y_test.shape}\")"
        ]
    }
    
    notebook['cells'].insert(experiment_idx, prep_cell)
    
    # Save the modified notebook
    with open('Assignment_Session_1_Neural_Networks.ipynb', 'w') as f:
        json.dump(notebook, f, indent=1)
    
    print("✅ Added data preparation cell before experiments!")
    print(f"   Inserted at position {experiment_idx}")
else:
    print("✅ Notebook already has preparation cell!")

print("\nNow run the preparation cell before running the experiment cells.")
