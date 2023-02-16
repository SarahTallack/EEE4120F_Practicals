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
using Statistics

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

print("Number of samples: ", size(whiteNoiseArray), "\n")
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

function corr(x,y)
    xavg = mean(x)
    yavg = mean(y)
    r = (sum((x.-xavg).*(y.-yavg)))/sqrt(sum((x.-xavg).^2))/sqrt(sum((y.-yavg).^2))
    return r
end
    
# 1.2.6 Comparing Correlation Function to Statistics Package's Correlation Function
r1 = corr(whiteNoiseArray,whiteNoise)
println("Using corr function: ", r1);

r2 = cor(whiteNoiseArray,whiteNoise)
println("Using Statistics.cor function: ", r2, "\n");

# 1.2.7 Correlation of Shifted Signals

function sinusoid(f, Ns)
    dt = 1/(Ns*f);
    t = 0:dt:1/f;
    rad = 2*pi*f.*t
    wave = sin.(rad);
    return wave
end

freq = [100, 1000, 48000];  # range of frequencies to test
Ns = [100, 1000, 10000];    # range of number of samples

for i in freq
    for j in Ns
        title = "Frequency of "* string(i)* "Hz, with "* string(j)* " samples"
        Plots.display(Plots.scatter(sinusoid(i,j),title = title,legend = false,xlabel = "Time",ylabel = "Amplitude"))
        sineWave = sinusoid(i,j);
        sineWaveShift = circshift(sineWave, 10);
        R = cor(sineWave,sineWaveShift);
        println(title);
        println("Correlation: ", R, "\n")
    end
end