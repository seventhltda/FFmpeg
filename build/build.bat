pushd D:\FFmpeg\build
call build_x86.bat %1%
call build_x64.bat %1%
popd