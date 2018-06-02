AUTOMAKE_OPTIONS = foreign subdir-objects

bin_PROGRAMS = adctest
adctest_SOURCES = \
../../../src/AVPTesterApp.cpp \
../../../src/AVPTesterMain.cpp \
../../../src/AboutADCTDialog.cpp \
../../../src/Analysers/Crosstalk.cpp \
../../../src/Analysers/FADGIAnalyser.cpp \
../../../src/Analysers/IMD.cpp \
../../../src/Analysers/SegmentLocator.cpp \
../../../src/Analysers/SpIS.cpp \
../../../src/Analysers/StepsFrequencyResponse.cpp \
../../../src/Analysers/THDNoise.cpp \
../../../src/AudioDevicesDialog.cpp \
../../../src/AudioDevicesPanel.cpp \
../../../src/AudioIO/AudioEngine.cpp \
../../../src/AudioIO/LevelAnalyser.cpp \
../../../src/AudioIO/ParametersQueue.cpp \
../../../src/DSP/FFTAnalyser.cpp \
../../../src/DSP/GenMetricQueue.cpp \
../../../src/DSP/HFFilter.cpp \
../../../src/DSP/KFFTWrapper.cpp \
../../../src/DSP/Utils/MathUtilities.cpp \
../../../src/DSP/adapters/RingBufferFloat.cpp \
../../../src/Devices/ADevicesManager.cpp \
../../../src/ParamEditDialog.cpp \
../../../src/ResultsDialog.cpp \
../../../src/SigGen/AudioFileWriter.cpp \
../../../src/SigGen/DualSineToneGenerator.cpp \
../../../src/SigGen/FADGIGenerator.cpp \
../../../src/SigGen/OctaveToneGenerator.cpp \
../../../src/SigGen/SingleSineToneGenerator.cpp \
../../../src/SigGen/WavFileWriter.cpp \
../../../src/System/Prefs.cpp \
../../../src/TestManager.cpp \
../../../src/Widgets/GButton.cpp \
../../../src/Widgets/RimPanel.cpp \
../../../src/Widgets/VuMeter.cpp \
../../../src/Widgets/awohSpin.cpp \
../../../src/ThirdParty/pa-ringbuffer/pa_ringbuffer.c \
../../../src/ThirdParty/kiss-fft/tools/kiss_fftr.c \
../../../src/ThirdParty/kiss-fft/kiss_fft.c \
../../../src/ThirdParty/wxMathPlot/mathplot.cpp

AM_CPPFLAGS = \
-I../../../src -I../../../src/ThirdParty/wxMathPlot \
-I../../../src/ThirdParty/pa-ringbuffer \
-I../../../src/ThirdParty/kiss-fft
AM_CXXFLAGS = -std=c++14

appdir = $(datadir)/applications

dist_app_DATA = adctest.desktop
