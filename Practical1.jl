#= 

Practical 1

Course: EEE4120F
Date: February 2023
Authors:    
    Sarah Tallack       TLLSAR002
    Heather Wimberley   WMBHEA001

=#

using WAV
using Dates
using Plots
using TickTock

# 1.2.1 Measuring Execution Time of rand()
# t_start = now();
whiteNoise = (rand(48000)*2).-1

WAV.wavwrite(whiteNoise, "whiteNoise.wav", Fs = 4800) #sample freq is 48 kHz
# t_end = now();

# execution = t_end - t_start;
# println(t_start);
# println(t_end);
# println(execution);

# 1.2.2 White Noise Generator Script

function createwhiten(N)
    noiseArray = Array{Float64}(undef,N*4800)
    for i in N*4800
        noiseArray[i] = (rand()*2).-1
    end
    WAV.wavwrite(noiseArray, "white_noise_sound1.wav", Fs = 4800) #sample freq is 48 kHz
    return noiseArray
end

tick()

whiteNoiseArray = createwhiten(10);
WAV.wavwrite(whiteNoiseArray,"white_noise_sound2.wav", Fs=4800)

tock()
# whiten = createwhiten(1000); #create 1000 seconds of white noise
# size(whiten);

# 1.2.3 Visual Confirmation of Uniform Distribution

h = Plots.histogram(whiteNoise,title = "Random Number Distribution",legend = false,xlabel = "Number Generated",ylabel = "Frequency")
Plots.display(h)

#readline() #this will stop the program at this point till you press enter

# 1.2.4 Timing Execution


# 1.2.5 Implementing Pearson's Correlation
#=
function corr()
    
=#
# 1.2.6 Comparing Correlation Function to Statistics Package's Correlation Function


# 1.2.7 Correlation of Shifted Signals