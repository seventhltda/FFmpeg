set MSYSTEM=MINGW64
start /wait C:\msys64\usr\bin\mintty -l build_x64.log -d /usr/bin/bash --login -i D:\FFmpeg\build\configure_ffmpeg.sh x86_64 %1%