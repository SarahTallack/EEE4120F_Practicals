#= 

Practical 1

Course: EEE4120F
Date: February 2023
Authors:    
    Sarah Tallack       TLLSAR002
    Heather Wimberley   WMBHEA001

=#

using WAV

# 1.2.1 Measuring Execution Time of rand()
whiteNoise = (rand(48000)*2).-1

WAV.wavwrite(whiteNoise, "whiteNoise.wav", Fs = 48000) #sample freq is 48 kHz


# 1.2.2 White Noise Generator Script


# 1.2.3 Visual Confirmation of Uniform Distribution


# 1.2.4 Timing Execution


# 1.2.6 Comparing Correlation Function to Statistics Package's Correlation Function


# 1.2.7 Correlation of Shifted Signals