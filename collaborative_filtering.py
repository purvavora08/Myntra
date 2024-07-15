import pandas as pd
import numpy as np
import pickle
from sklearn.decomposition import TruncatedSVD

# Load image features
with open('image_features.pkl', 'rb') as f:
    image_features = pickle.load(f)

# Example user-item interaction data (replace this with your actual data)
data = {
    'user_id': [1, 1, 2, 2, 3, 3],
    'item_id': ['image1.jpg', 'image2.jpg', 'image1.jpg', 'image3.jpg', 'image2.jpg', 'image3.jpg'],
    'rating': [5, 4, 4, 5, 3, 4]
}
df = pd.DataFrame(data)

# Create a pivot table
pivot_table = df.pivot_table(index='user_id', columns='item_id', values='rating').fillna(0)
print("Pivot Table:")
print(pivot_table)

# Check the values of the pivot table
values = pivot_table.values
print("Pivot Table Values:")
print(values)

# Matrix factorization using SVD
try:
    n_components = min(values.shape[1], 3)  # Set n_components to 3 or fewer
    svd = TruncatedSVD(n_components=n_components, random_state=42)
    matrix = svd.fit_transform(values)
    print("Matrix after SVD:")
    print(matrix)
except Exception as e:
    print(f"Error during SVD: {e}")

# Calculate similarity matrix
try:
    item_similarity = np.corrcoef(matrix.T)
    print("Item Similarity Matrix:")
    print(item_similarity)

    # Save the similarity matrix
    with open('item_similarity.pkl', 'wb') as f:
        pickle.dump(item_similarity, f)
except Exception as e:
    print(f"Error during similarity matrix calculation: {e}")

    