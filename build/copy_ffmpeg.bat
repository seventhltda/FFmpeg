setlocal
set PATH=%SystemRoot%\system32;%SystemRoot%;%SystemRoot%\System32\Wbem

if "%2%" == "" goto REMOTE
if "%2%" == "local" goto LOCAL

:REMOTE
set destDir=\\192.168.0.6\Releases\FFmpeg\3.0.2
net use "%destDir%" seventh /user:jenkins
goto BUILD

:LOCAL
set destDir=D:\FFmpeg\build

:BUILD
rd /s /q %destDir%\%1%\
md %destDir%\%1%\

pushd D:\FFmpeg
copy libavcodec\avcodec-57.dll %destDir%\%1%\
copy libavdevice\avdevice-57.dll %destDir%\%1%\
copy libavfilter\avfilter-6.dll %destDir%\%1%\
copy libavformat\avformat-57.dll %destDir%\%1%\
copy libavutil\avutil-55.dll %destDir%\%1%\
copy libpostproc\postproc-54.dll %destDir%\%1%\
copy libswresample\swresample-2.dll %destDir%\%1%\
copy libswscale\swscale-4.dll %destDir%\%1%\
copy ffmpeg.exe %destDir%\%1%\
copy ffplay.exe %destDir%\%1%\
popd

pushd D:\FFmpeg\build
move /Y *.log %destDir%\%1%\
popd

pushd %destDir%\%1%\
ffmpeg.exe -formats > formats.txt
ffmpeg.exe -codecs > codecs.txt
ffmpeg.exe -protocols > protocols.txt
popd

endlocal
exit %errorlevel%