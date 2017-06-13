rem x86 build - Start
pushd D:\FFmpeg
set path=D:\FFmpeg\build\mingw32\msys\bin;D:\FFmpeg\build\mingw32\bin
make distclean
make clean
sh --login -i "D:\FFmpeg\build\configure_ffmpeg.sh" x86
make
popd
copy_ffmpeg.bat x86
rem x86 build - End