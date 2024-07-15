import os
import numpy as np
from tensorflow.keras.applications.vgg16 import VGG16, preprocess_input
from tensorflow.keras.preprocessing.image import load_img, img_to_array
from tensorflow.keras.models import Model
import pickle

# Load VGG16 model pre-trained on ImageNet
base_model = VGG16(weights='imagenet')
model = Model(inputs=base_model.input, outputs=base_model.get_layer('fc1').output)

def extract_features(directory):
    features = {}
    for filename in os.listdir(directory):
        if filename.endswith('.jpg') or filename.endswith('.png') or filename.endswith('.jpeg'):
            # Load an image
            image = load_img(os.path.join(directory, filename), target_size=(224, 224))
            image = img_to_array(image)
            image = np.expand_dims(image, axis=0)
            image = preprocess_input(image)

            # Extract features
            feature = model.predict(image)
            features[filename] = feature.flatten()
    return features

# Directory containing your images
image_directory = 'assets\images'
features = extract_features(image_directory)

# Save features to a pickle file
with open('image_features.pkl', 'wb') as f:
    pickle.dump(features, f)

    