from flask import Flask, request, jsonify
import pickle
import numpy as np

app = Flask(__name__)

# Load image features and similarity matrix
with open('image_features.pkl', 'rb') as f:
    image_features = pickle.load(f)

with open('item_similarity.pkl', 'rb') as f:
    item_similarity = pickle.load(f)

items = list(image_features.keys())
print("Available items:", items)

def get_recommendations(item_id, similarity_matrix, items, top_n=5):
    if item_id not in items:
        return []
    idx = items.index(item_id)
    sim_scores = list(enumerate(similarity_matrix[idx]))
    sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)
    sim_scores = sim_scores[1:top_n+1]
    item_indices = [i[0] for i in sim_scores]
    return [items[i] for i in item_indices]

@app.route('/recommend', methods=['GET'])
def recommend():
    item_id = request.args.get('item_id')
    recommendations = get_recommendations(item_id, item_similarity, items)
    if not recommendations:
        return jsonify({"error": f"Item ID '{item_id}' not found in the dataset."}), 404
    return jsonify(recommendations)

if __name__ == '__main__':
    app.run(debug=True)