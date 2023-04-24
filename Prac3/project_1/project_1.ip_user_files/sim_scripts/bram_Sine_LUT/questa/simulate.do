onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib bram_Sine_LUT_opt

do {wave.do}

view wave
view structure
view signals

do {bram_Sine_LUT.udo}

run -all

quit -force
