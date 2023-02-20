using Statistics
using Plots

function main()
# 1.2.7 Correlation of Shifted Signals

# freq = [50, 1000, 48000]   # range of frequencies to test
Ns = [100, 1000, 10000]    # range of number of samples
shift = [0.25, 0.5, 0.75]

local sineWave, sineWaveShift

    for j in Ns
        for k in shift
            shifted = floor(Int, j*k)
            sineWave = sinusoid(1000,j)
            sineWaveShift = circshift(sineWave, shifted)
            R = cor(sineWave,sineWaveShift)
            println("Frequency of 1000 Hz, with ", string(j), " samples, shifted by ", shifted, " samples")
            println("Correlation: ", R, "\n")

            h = Plots.scatter(sineWave,title = "Sine Wave",xlabel = "Time",ylabel = "Amplitude", label = "Original Wave", color = "blue")
            h = Plots.scatter!(sineWaveShift, label = "Shifted Wave", color = "red")
            Plots.display(h)    
            savefig(h, "C:\\Users\\sarah\\Documents\\1. UNIVERSITY\\University\\EEE4120F\\EEE4120F_Practicals\\Plots\\Sine\\SineWaveCheck 1000 Hz"*string(j)*"samples"*string(shifted)*"samplesshifted") 
        end
    end
    println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")


    for j in Ns
        shifted = [10, 50]
        for k in shifted
            sineWave = sinusoid(1000,j)
            sineWaveShift = circshift(sineWave, k)
            R = cor(sineWave,sineWaveShift)
            println("Frequency of 1000 Hz, with ", string(j), " samples, shifted by ", k, " samples")
            println("Correlation: ", R, "\n")

            h = Plots.scatter(sineWave,title = "Sine Wave",xlabel = "Time",ylabel = "Amplitude", label = "Original Wave", color = "blue")
            h = Plots.scatter!(sineWaveShift, label = "Shifted Wave", color = "red")
            Plots.display(h)    
            savefig(h, "C:\\Users\\sarah\\Documents\\1. UNIVERSITY\\University\\EEE4120F\\EEE4120F_Practicals\\Plots\\Sine\\SineWaveCheck 1000 Hz"*string(j)*"samples"*string(k)*"samplesshifted") 
        end
    end
    println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
end

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

main()