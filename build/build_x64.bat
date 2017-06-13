rem x64 build - Start
pushd D:\FFmpeg
set path=D:\FFmpeg\build\mingw64\msys\bin;D:\FFmpeg\build\mingw64\bin
make distclean
make clean
sh --login -i "D:\FFmpeg\build\configure_ffmpeg.sh" x86_64
make
popd
copy_ffmpeg.bat x64
rem x64 build - End