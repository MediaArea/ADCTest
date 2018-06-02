#! /bin/sh

##################################################################

Parallel_Make () {
    local numprocs=1
    case $OS in
    'linux')
        numprocs=`grep -c ^processor /proc/cpuinfo 2>/dev/null`
        ;;
    'mac') 
        if type sysctl &> /dev/null; then
            numprocs=`sysctl -n hw.ncpu`
        fi
        ;;
    *) ;;
    esac
    if [ "$numprocs" = "" ] || [ "$numprocs" = "0" ]; then
        numprocs=1
    fi
    make -s -j$numprocs
}

##################################################################
# Init

Home=`pwd`
# For wx compilation
MacOptions="--with-macosx-version-min=10.9"

OS=$(uname -s)
# expr isn’t available on mac
if [ "$OS" = "Darwin" ]; then
    OS="mac"
# if the 5 first caracters of $OS equal "Linux"
elif [ "$(expr substr $OS 1 5)" = "Linux" ]; then
    OS="linux"
#elif [ "$(expr substr $OS 1 5)" = "SunOS" ]; then
#    OS="solaris"
#elif [ "$(expr substr $OS 1 7)" = "FreeBSD" ]; then
#    OS="freebsd"
fi

##################################################################
# libsndfile

if test -e libsndfile/configure; then
    cd libsndfile
    test -e Makefile && rm Makefile
    chmod +x configure
    if [ "$OS" = "mac" ]; then
        ./configure --enable-static --disable-shared $MacOptions $*
    else
        ./configure --enable-static --disable-shared $*
    fi
    if test -e Makefile; then
        make clean
        Parallel_Make
        if test -e src/libsndfile.la; then
            echo libsndfile compiled
        else
            echo Problem while compiling libsndfile
            exit
        fi
    else
        echo Problem while configuring libsndfile
        exit
    fi
else
    echo libsndfile directory is not found
    exit
fi
cd $Home

##################################################################
# PortAudio

if test -e portaudio/configure; then
    cd portaudio
    test -e Makefile && rm Makefile
    chmod +x configure
    if [ "$OS" = "mac" ]; then
        ./configure --enable-static --disable-shared $MacOptions $*
    else
        ./configure --enable-static --disable-shared $*
    fi
    if test -e Makefile; then
        make clean
        Parallel_Make
        if test -e lib/libportaudio.la; then
            echo PortAudio compiled
        else
            echo Problem while compiling PortAudio
            exit
        fi
    else
        echo Problem while configuring PortAudio
        exit
    fi
else
    echo PortAudio directory is not found
    exit
fi
cd $Home

##################################################################
# wxWidgets

if test -e wxWidgets/configure; then
    cd wxWidgets
    test -e Makefile && rm Makefile
    chmod +x configure
    if [ "$OS" = "mac" ]; then
        ./configure --with-libpng --enable-monolithic --disable-shared $MacOptions $*
    else
        ./configure --with-libpng --enable-monolithic --disable-shared $*
    fi
    if test -e Makefile; then
        make clean
        Parallel_Make
        if test -e lib/libwxjpeg-*.a; then
            echo wxWidgets compiled
        else
            echo Problem while compiling wxWidgets
            exit
        fi
    else
        echo Problem while configuring wxWidgets
        exit
    fi
else
    echo wxWidgets directory is not found
    exit
fi
cd $Home

##################################################################
# MediaInfo (GUI)

if test -e ADCTest/Project/GNU/GUI/configure; then
    cd ADCTest/Project/GNU/GUI/
    test -e Makefile && rm Makefile
    chmod +x configure
    if [ "$OS" = "mac" ]; then
        ./configure $MacOptions $*
    else
        ./configure $*
    fi
    if test -e Makefile; then
        make clean
        Parallel_Make
        if test -e adctest; then
            echo "ADCTest compiled"
        else
            echo "Problem while compiling ADCTest"
            exit
        fi
    else
        echo "Problem while configuring ADCTest"
        exit
    fi
else
    echo ADCTest directory is not found
    exit
fi
cd $Home

##################################################################

echo "MediaInfo executable is ADCTest/Project/GNU/GUI/adctest"
echo "For installing, cd ADCTest/Project/GNU/GUI && make install"

unset -v Home MacOptions OS
