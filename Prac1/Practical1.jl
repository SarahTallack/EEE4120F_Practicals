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

ENV["TICKTOCK_MESSAGES"] = false

function main()
    # 1.2.1 Measuring Execution Time of rand()
    N = [5, 10, 50, 100];
    n = length(N);
    timeRand , timecreateWhiten, sampleSize, whiteNoise, whiteNoiseArray = whiteNoiseGeneration(20)

    for i in 1:n
        timeRand , timecreateWhiten, sampleSize, whiteNoise, whiteNoiseArray = whiteNoiseGeneration(N[i])
        println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        println("Time = ", N[i])
        println("Execution Time of rand() = ", timeRand)
        println("Execution Time of createWhiten() = ", timecreateWhiten)
        println("Sample size = ", sampleSize)
        println()

        # 1.2.3 Visual Confirmation of Uniform Distribution
        h = Plots.histogram(whiteNoise,title = "Rand() function distributin for T = "*string(N[i])*"s",legend = false,xlabel = "Number Generated",ylabel = "Frequency")
        Plots.display(h)
        savefig(h, "C:\\Users\\sarah\\Documents\\1. UNIVERSITY\\University\\EEE4120F\\EEE4120F_Practicals\\Plots\\Noise\\NoiseRand"*string(N[i])*"secs") 
        h = Plots.histogram(whiteNoiseArray,title = "createWhiten() function distribution for T = "*string(N[i])*"s",legend = false,xlabel = "Number Generated",ylabel = "Frequency")
        Plots.display(h)
        savefig(h, "C:\\Users\\sarah\\Documents\\1. UNIVERSITY\\University\\EEE4120F\\EEE4120F_Practicals\\Plots\\Noise\\createWhiten"*string(N[i])*"secs") 
        
        # 1.2.6 Comparing Correlation Function to Statistics Package's Correlation Function

        # Correlation of createWhiten() function output against itself
        println("Correlation of createWhiten() function output against itself")
        timeCorr, timeStatsCor = correlationCompare(whiteNoiseArray, whiteNoiseArray)
        
        # Correlation of createWhiten() function output against rand() function output
        println("Correlation of createWhiten() and rand() function outputs")
        timeCorr, timeStatsCor = correlationCompare(whiteNoiseArray, whiteNoise)
    end
    println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
    
    # 1.2.7 Correlation of Shifted Signals

    freq = [50, 1000, 48000]   # range of frequencies to test
    Ns = [100, 1000, 10000]    # range of number of samples
    shift = [0.25, 0.5, 0.75]

    local sineWave, sineWaveShift
    for i in freq
        for j in Ns
            for k in shift
                shifted = floor(Int, j*k)
                sineWave = sinusoid(i,j)
                sineWaveShift = circshift(sineWave, shifted)
                R = cor(sineWave,sineWaveShift)
                println("Frequency of ", string(i), "Hz, with ", string(j), " samples, shifted by ", shifted, " samples")
                println("Correlation: ", R, "\n")

                h = Plots.scatter(sineWave,title = "Sine Wave",xlabel = "Time",ylabel = "Amplitude", label = "Original Wave", color = "blue")
                h = Plots.scatter!(sineWaveShift, label = "Shifted Wave", color = "red")
                Plots.display(h)    
                savefig(h, "C:\\Users\\sarah\\Documents\\1. UNIVERSITY\\University\\EEE4120F\\EEE4120F_Practicals\\Plots\\Sine\\SineWave"*string(i)*"Hz"*string(j)*"samples"*string(shifted)*"samplesshifted") 
            end
        end
        println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
    end
end

# 1.2.2 White Noise Generator Script
function createWhiten(N)
    noiseArray = Array{Float64}(undef,N*4800)
    for i in 1:N*4800
        noiseArray[i] = (rand()*2).-1
    end
    WAV.wavwrite(noiseArray, "white_noise_sound1.wav", Fs = 4800) #sample freq is 4.8 kHz
    return noiseArray
end

function whiteNoiseGeneration(N)
    # where N is the number of seconds
    tick();
    whiteNoise = (rand(4800*N)*2).-1
    WAV.wavwrite(whiteNoise, "whiteNoise.wav", Fs = 4800); #sample freq is 48 kHz
    timeRand = tok();
    #println("Execution time of rand() function: ", timeRand, "s \n")

    # 1.2.2 White Noise Generator Script
    tick();
    whiteNoiseArray = createWhiten(N);
    WAV.wavwrite(whiteNoiseArray, "white_noise_sound2.wav", Fs = 4800);
    timecreateWhiten = tok();
    
    #println("Execution time of createWhiten() function: ", timecreateWhiten, "s \n")
    sampleSize = length(whiteNoiseArray);

    return timeRand , timecreateWhiten, sampleSize, whiteNoise, whiteNoiseArray
end

# 1.2.5 Implementing Pearson's Correlation
function corr(x,y)
    xavg = mean(x)
    yavg = mean(y)
    r = (sum((x.-xavg).*(y.-yavg)))/sqrt(sum((x.-xavg).^2))/sqrt(sum((y.-yavg).^2))
    return r
end

#1.2.6 Comparing Your Correlation Function to the Statistics Package's Correlation Function
function correlationCompare(A, B)
    println("Comparing output and time of corr() and Statistics.cor() functions")
    tick()
    r1 = corr(A, B)
    timeCorr = tok()
    println("Using corr function: ", r1)
    println("Execution time of corr() function: ", timeCorr)

    tick()
    r2 = cor(A, B)
    timeStatsCor = tok()
    println("Using Statistics.cor function: ", r2)
    println("Execution time of Statistics.cor() function: ", timeStatsCor)
    
    println()
    return timeCorr, timeStatsCor
end
    
# 1.2.7 Correlation of Shifted Signals
function sinusoid(f, Ns)
    # function to generate a single period of a sinusoid given its 
    # frequency and the number of samples. 
    # The sinusoid is stored in an array
    dt = 1/(Ns*f);
    t = dt:dt:1/f;
    rad = 2*pi*f.*t;
    wave = sin.(rad);
    return wave
end

function speedUp(t1, t2) 
    #function to determine and print the speedup using the formula speedup = t1/t2
    #t1 is the runtime of original/non-optimal program, t2 is the runtime of optimisted program
    #both t1 and t2 need to have the same units
    speedup = t1/t2;
    println("Speedup = ", speedup)
end

main()

