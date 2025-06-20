from flask import Flask, request, jsonify
from sklearn.cluster import KMeans
import numpy as np

app = Flask(__name__)

@app.route("/predict", methods=["POST"])
def predict():
    basket = request.json.get("basket")
    if not basket:
        return jsonify({"error": "Basket missing"}), 400

    vec = np.array(basket).reshape(1, -1)
    model = KMeans(n_clusters=2, random_state=0).fit([[1, 0], [0, 1]])
    label = model.predict(vec)[0]

    return jsonify({"cluster": int(label)})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001)
