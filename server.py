from flask import Flask, request, jsonify

app = Flask(__name__)

# Example items in your inventory
items = [
    {'id': 1, 'name': 'fashionscale.jpeg', 'category': 'fashion'},
    {'id': 2, 'name': 'gofor.jpeg', 'category': 'fashion'},
    {'id': 3, 'name': 'heels.jpg', 'category': 'shoes'},
    {'id': 4, 'name': 'Home.jpeg', 'category': 'home'},
    {'id': 5, 'name': 'lamp.jpg', 'category': 'home'},
    {'id': 6, 'name': 'product.jpeg', 'category': 'fashion'},
    {'id': 7, 'name': 'style.jpeg', 'category': 'fashion'},
    {'id': 8, 'name': 'trolly.jpg', 'category': 'fashion'},
    {'id': 9, 'name': 'watch.jpg', 'category': 'accessories'},
    {'id': 10, 'name': 'women.jpg', 'category': 'fashion'},
]

# Sample recommendation function
def recommend(category, limit=5):
    # Filter items by category and return the top 'limit' items
    recommended_items = [item for item in items if item['category'] == category]
    return recommended_items[:limit]

@app.route('/')
def home():
    return "Hello, Flask!"

@app.route('/recommend', methods=['GET'])
def get_recommendations():
    # Get category from request args
    category = request.args.get('category', 'fashion')
    limit = int(request.args.get('limit', 5))

    # Get recommendations
    recommendations = recommend(category, limit)

    return jsonify(recommendations)

if __name__ == '__main__':
    app.run(debug=True)
