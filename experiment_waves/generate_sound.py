import sys
import cv2
import numpy as np
import pygame
import soundfile as sf
from pydub import AudioSegment
import imageio


# Define a function to play a tone based on frequency and duration
def play_tone(frequency, duration):
    print("ALO")
    sound = pygame.mixer.Sound(buffer=frequency)
    sound.play()
    pygame.time.delay(int(duration * 1000))
    return sound


def convert_to_sound(image, wav_name):
    print("SI ENTRA")
    # Convert the image to grayscale
    gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # Apply thresholding
    _, binary_image = cv2.threshold(gray_image, 127, 255, cv2.THRESH_BINARY_INV)

    # Find contours
    contours, _ = cv2.findContours(
        binary_image, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE
    )

    # Filter circles based on contour area or any other criteria
    min_radius = 20
    max_radius = 100
    filtered_circles = [
        contour
        for contour in contours
        if min_radius**2 * np.pi < cv2.contourArea(contour) < max_radius**2 * np.pi
    ]

    # Set the number of mixer channels
    num_channels = 1

    combined_sound = pygame.mixer.Sound(
        np.zeros(1, dtype=np.int16)
    )  # Create an empty sound object
    sound_buffers = []
    # Calculate the distances between circles and play tones
    for i in range(len(filtered_circles)):
        for j in range(i + 1, len(filtered_circles)):
            M1 = cv2.moments(filtered_circles[i])
            M2 = cv2.moments(filtered_circles[j])

            cx1, cy1 = int(M1["m10"] / M1["m00"]), int(M1["m01"] / M1["m00"])
            cx2, cy2 = int(M2["m10"] / M2["m00"]), int(M2["m01"] / M2["m00"])

            # Draw circles on the image
            cv2.circle(image, (cx1, cy1), int(min_radius), (0, 255, 0), 2)
            cv2.circle(image, (cx2, cy2), int(min_radius), (0, 255, 0), 2)

            # Calculate Euclidean distance
            distance = np.sqrt((cx2 - cx1) ** 2 + (cy2 - cy1) ** 2)

            # Map distance to a frequency (adjust the mapping as needed)
            min_distance, max_distance = 0, 500
            min_frequency, max_frequency = 220, 880

            # Map the distance to a frequency within the specified range
            frequency = np.interp(
                distance, [min_distance, max_distance], [min_frequency, max_frequency]
            )

            # Generate a sine wave for the specified frequency
            sample_rate, duration = 44100, 0.5
            t = np.linspace(0, duration, int(sample_rate * duration), endpoint=False)
            wave = (0.5 * np.sin(2 * np.pi * frequency * t) * 32767).astype(np.int16)

            # Play the tone
            current_sound = play_tone(wave, duration=duration)
            sound_buffers.append(current_sound)

    # Combine sound buffers into a single NumPy array
    combined_buffer = np.concatenate(sound_buffers)

    # Save the combined sound to a temporary WAV file
    temp_wav_file = wav_name + ".wav"
    sf.write(temp_wav_file, combined_buffer, pygame.mixer.get_init()[0])

    # Display the image with circles
    imageio.imwrite(wav_name + ".png", image)
    cv2.imshow("Circles", image)
    cv2.waitKey(0)
    cv2.destroyAllWindows()
    cv2.waitKey(1)


if __name__ == "__main__":
    path_prefix, time_stamp, iteration = sys.argv[1:]
    image_path = f"frames/{time_stamp}_{iteration}_sound_frame.png"
    pygame.init()
    pygame.mixer.init()
    image = cv2.imread(image_path)
    wav_name = f"sounds/{time_stamp}_{iteration}_sound_frame"
    convert_to_sound(image, wav_name)
