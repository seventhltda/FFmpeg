setlocal
set PATH=%SystemRoot%\system32;%SystemRoot%;%SystemRoot%\System32\Wbem

net use "\\192.168.0.6\Releases\FFmpeg\3.2.2" seventh /user:jenkins
rd /s /q \\192.168.0.6\Releases\FFmpeg\3.2.2\%1%\
md \\192.168.0.6\Releases\FFmpeg\3.2.2\%1%\

pushd D:\FFmpeg
:: copy dependencies\*.dll \\192.168.0.6\Releases\FFmpeg\3.2.2\%1%\
copy libavcodec\avcodec-57.dll \\192.168.0.6\Releases\FFmpeg\3.2.2\%1%\
copy libavdevice\avdevice-57.dll \\192.168.0.6\Releases\FFmpeg\3.2.2\%1%\
copy libavfilter\avfilter-6.dll \\192.168.0.6\Releases\FFmpeg\3.2.2\%1%\
copy libavformat\avformat-57.dll \\192.168.0.6\Releases\FFmpeg\3.2.2\%1%\
copy libavutil\avutil-55.dll \\192.168.0.6\Releases\FFmpeg\3.2.2\%1%\
copy libpostproc\postproc-54.dll \\192.168.0.6\Releases\FFmpeg\3.2.2\%1%\
copy libswresample\swresample-2.dll \\192.168.0.6\Releases\FFmpeg\3.2.2\%1%\
copy libswscale\swscale-4.dll \\192.168.0.6\Releases\FFmpeg\3.2.2\%1%\
copy ffmpeg.exe \\192.168.0.6\Releases\FFmpeg\3.2.2\%1%\
popd

pushd D:\FFmpeg\build
move /Y *.log \\192.168.0.6\Releases\FFmpeg\3.2.2\%1%\
popd

pushd \\192.168.0.6\Releases\FFmpeg\3.2.2\%1%\
ffmpeg.exe -formats > formats.txt
ffmpeg.exe -codecs > codecs.txt
ffmpeg.exe -protocols > protocols.txt
popd

endlocal
exit %errorlevel%