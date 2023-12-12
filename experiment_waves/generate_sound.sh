#!/bin/bash

time_stamp="$1"
pathPrefix="$2"
iteration="$3"
python_path="$4"

cd "$pathPrefix"

# Create a virtual environment
python3 -m venv venv

# Activate the virtual environment
source venv/bin/activate

# Install required packages within the virtual environment
pip3 install numpy opencv-python pygame soundfile pydub imageio

# Run the Python script within the virtual environment
python3 generate_sound.py "$pathPrefix" "$time_stamp" "$iteration"

# Deactivate the virtual environment
deactivate
