#= 
Practical 1

Course: EEE4120F
Date: February 2023
Authors:    
    Sarah Tallack       TLLSAR002
    Heather Wimberley   WMBHEA001
=#

using WAV
using Plots
using TickTock
using Statistics


function main()
    # 1.2.1 Measuring Execution Time of rand()
    tick()

    whiteNoise = (rand(48000)*2).-1
    WAV.wavwrite(whiteNoise, "whiteNoise.wav", Fs = 48000); #sample freq is 48 kHz
    
    tock()

    # 1.2.2 White Noise Generator Script

    tick()

    whiteNoiseArray = createwhiten(10);
    WAV.wavwrite(whiteNoiseArray, "white_noise_sound2.wav", Fs=4800);

    tock()

    # 1.2.3 Visual Confirmation of Uniform Distribution

    h = Plots.histogram(whiteNoise,title = "Random Number Distribution",legend = false,xlabel = "Number Generated",ylabel = "Frequency")
    Plots.display(h)

    h = Plots.histogram(whiteNoiseArray,title = "Other",legend = false,xlabel = "Number Generated",ylabel = "Frequency")
    Plots.display(h)

    # 1.2.4 Timing Execution


    # 1.2.6 Comparing Correlation Function to Statistics Package's Correlation Function
    r1 = corr(whiteNoiseArray,whiteNoise)
    println("Using corr function: ", r1);

    r2 = cor(whiteNoiseArray,whiteNoise)
    println("Using Statistics.cor function: ", r2, "\n");

    # 1.2.7 Correlation of Shifted Signals

    freq = [100, 1000, 48000];  # range of frequencies to test
    Ns = [100, 1000, 10000];    # range of number of samples

    for i in freq
        for j in Ns
            title = "Frequency of "* string(i)* "Hz, with "* string(j)* " samples"
            #Plots.display(Plots.scatter(sinusoid(i,j),title = title,legend = false,xlabel = "Time",ylabel = "Amplitude"))
            sineWave = sinusoid(i,j);
            sineWaveShift = circshift(sineWave, 10);
            R = cor(sineWave,sineWaveShift);
            println(title);
            println("Correlation: ", R, "\n")
        end
    end

end

# 1.2.2 White Noise Generator Script
function createwhiten(N)
    noiseArray = Array{Float64}(undef,N*4800)
    for i in 1:N*4800
        noiseArray[i] = (rand()*2).-1
    end
    WAV.wavwrite(noiseArray, "white_noise_sound1.wav", Fs = 4800) #sample freq is 4.8 kHz
    return noiseArray
end

# 1.2.5 Implementing Pearson's Correlation
function corr(x,y)
    xavg = mean(x)
    yavg = mean(y)
    r = (sum((x.-xavg).*(y.-yavg)))/sqrt(sum((x.-xavg).^2))/sqrt(sum((y.-yavg).^2))
    return r
end
    
# 1.2.7 Correlation of Shifted Signals

function sinusoid(f, Ns)
    # function to generate a single period of a sinusoid given its 
    # frequency and the number of samples. 
    # The sinusoid is stored in an array
    dt = 1/(Ns*f);
    t = 0:dt:1/f;
    rad = 2*pi*f.*t;
    wave = sin.(rad);
    return wave
end

main()

