net use "\\192.168.0.6\Releases\FFmpeg\3.0.2" seventh /user:jenkins
rd /s /q \\192.168.0.6\Releases\FFmpeg\3.0.2\%1%\
md \\192.168.0.6\Releases\FFmpeg\3.0.2\%1%\
pushd D:\FFmpeg
copy dependencies\libiconv-2.dll \\192.168.0.6\Releases\FFmpeg\3.0.2\%1%\
copy libavcodec\avcodec-56.dll \\192.168.0.6\Releases\FFmpeg\3.0.2\%1%\
copy libavdevice\avdevice-56.dll \\192.168.0.6\Releases\FFmpeg\3.0.2\%1%\
copy libavfilter\avfilter-5.dll \\192.168.0.6\Releases\FFmpeg\3.0.2\%1%\
copy libavformat\avformat-56.dll \\192.168.0.6\Releases\FFmpeg\3.0.2\%1%\
copy libavutil\avutil-54.dll \\192.168.0.6\Releases\FFmpeg\3.0.2\%1%\
copy libpostproc\postproc-53.dll \\192.168.0.6\Releases\FFmpeg\3.0.2\%1%\
copy libswresample\swresample-1.dll \\192.168.0.6\Releases\FFmpeg\3.0.2\%1%\
copy libswscale\swscale-3.dll \\192.168.0.6\Releases\FFmpeg\3.0.2\%1%\
copy ffmpeg.exe \\192.168.0.6\Releases\FFmpeg\3.0.2\%1%\
popd
pushd \\192.168.0.6\Releases\FFmpeg\3.0.2\%1%\
ffmpeg.exe -formats > formats.txt
ffmpeg.exe -codecs > codecs.txt
ffmpeg.exe -protocols > protocols.txt
popd