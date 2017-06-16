set MSYSTEM=MINGW32
start /wait C:\msys64\usr\bin\mintty -l build_x86.log -d /usr/bin/bash --login -i D:\FFmpeg\build\configure_ffmpeg.sh x86 %1%