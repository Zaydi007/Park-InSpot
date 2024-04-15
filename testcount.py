import cv2
import pandas as pd
import numpy as np
from ultralytics import YOLO
import time
import threading
import parking_spot_counter  # Importing functions from the other file

# Define parking areas
parking_areas = [
    [(52, 364), (30, 417), (73, 412), (88, 369)],
    [(105, 353), (86, 428), (137, 427), (146, 358)],
    [(159, 354), (150, 427), (204, 425), (203, 353)],
    [(217, 352), (219, 422), (273, 418), (261, 347)],
    [(274, 345), (286, 417), (338, 415), (321, 345)],
    [(336, 343), (357, 410), (409, 408), (382, 340)],
    [(396, 338), (426, 404), (479, 399), (439, 334)],
    [(458, 333), (494, 397), (543, 390), (495, 330)],
    [(511, 327), (557, 388), (603, 383), (549, 324)],
    [(564, 323), (615, 381), (654, 372), (596, 315)],
    [(616, 316), (666, 369), (703, 363), (642, 312)],
    [(674, 311), (730, 360), (764, 355), (707, 308)]
]

# Initialize YOLO model
model = YOLO('yolov8s.pt')

# Function to handle mouse events
def RGB(event, x, y, flags, param):
    if event == cv2.EVENT_MOUSEMOVE :  
        colorsBGR = [x, y]
        print(colorsBGR)

# Set up OpenCV window
cv2.namedWindow('RGB')
cv2.setMouseCallback('RGB', RGB)

# Open video capture
cap = cv2.VideoCapture('parking1.mp4')

# Read class labels from file
with open("coco.txt", "r") as file:
    class_list = file.read().split("\n")

# Main loop for processing video frames
while True:    
    ret, frame = cap.read()
    if not ret:
        break
    time.sleep(1)
    frame = cv2.resize(frame, (1020, 500))

    # Predict using YOLO model
    results = model.predict(frame)
    boxes = results[0].boxes.data
    df = pd.DataFrame(boxes).astype("float")

    # Lists to hold counts for each parking area
    parking_counts = []

    # Iterate through detected objects
    for _, row in df.iterrows():
        x1, y1, x2, y2, _, d = map(int, row)
        c = class_list[d]
        
        # If the detected object is a car
        if 'car' in c:
            cx, cy = (x1 + x2) // 2, (y1 + y2) // 2
            
            # Check if the car is inside any parking area
            parking_count = sum([cv2.pointPolygonTest(np.array(area, np.int32), (cx, cy), False) >= 0 for area in parking_areas])
            
            parking_counts.append(parking_count)

            # Draw bounding box and label for the car
            cv2.rectangle(frame, (x1, y1), (x2, y2), (0, 255, 0), 2)
            cv2.circle(frame, (cx, cy), 3, (0, 0, 255), -1)
            cv2.putText(frame, str(c), (x1, y1), cv2.FONT_HERSHEY_COMPLEX, 0.5, (255, 255, 255), 1)

    # Calculate available parking spots
    occupied_spots = sum(parking_counts)
    available_spots = len(parking_areas) - occupied_spots

    # Display parking area status
    # Display parking area status
    for i, area in enumerate(parking_areas, start=1):
        color = (0, 0, 255) if i <= len(parking_counts) and parking_counts[i-1] > 0 else (0, 255, 0)
        cv2.polylines(frame, [np.array(area, np.int32)], True, color, 2)
        cv2.putText(frame, str(i), (area[0][0], area[0][1] + 25), cv2.FONT_HERSHEY_COMPLEX, 0.5, color, 1)

    # Display available parking spots count
    cv2.putText(frame, str(available_spots), (23, 30), cv2.FONT_HERSHEY_PLAIN, 3, (255, 255, 255), 2)

    # Show the frame
    cv2.imshow("RGB", frame)

    # Break the loop if 'Esc' is pressed
    if cv2.waitKey(1) & 0xFF == 27:
        break

# Release the video capture and close OpenCV windows
cap.release()
cv2.destroyAllWindows()
