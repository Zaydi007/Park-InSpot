from flask import Flask, jsonify
import threading

# Define space variable
space = 0

app = Flask(__name__)

# Route to get parking spot count
@app.route('/parking_spots', methods=['GET'])
def get_parking_spots():
    global space  # Importing global space variable
    return jsonify({'availableParkingSpots': space})

if __name__ == '__main__':
    # Run Flask app
    app.run(debug=True)
