# Navigate to the project workspace (FFmpeg root source directory) and configure FFmpeg
cd "D:/FFmpeg/"

make distclean
make clean

ldflags="-static"

flags="--enable-shared --enable-static"
flags="--pkg-config=pkg-config --enable-ffmpeg --enable-ffplay"
flags="$flags --enable-zlib --enable-small --optflags=-O2"
flags="$flags --enable-yasm --enable-asm --enable-hwaccels"
flags="$flags --enable-shared"
flags="$flags --enable-gpl --enable-nonfree --enable-libx264 --enable-libmp3lame"
flags="$flags --enable-protocol=concat --enable-protocol=file --enable-protocol=rtp"
flags="$flags --enable-filter=color --enable-filter=smptebars --enable-filter=testsrc --enable-filter=nullsrc"
flags="$flags --enable-filter=anullsrc --enable-filter=anoisesrc --enable-filter=aevalsrc"
flags="$flags --enable-filter=concat --enable-filter=fps --enable-filter=subtitles --enable-filter=aresample"
flags="$flags --enable-indev=lavfi"
flags="$flags --enable-bsf=h264_mp4toannexb --enable-bsf=hevc_mp4toannexb"
flags="$flags --enable-cross-compile --arch=$1 --target-os=mingw32"

echo LDFLAGS=$ldflags
echo FLAGS-$flags

./configure --extra-ldflags=$ldflags $flags

make

dirName=$1
if [ $dirName == "x86_64" ]; then
  dirName="x64"
fi

cd "D:/FFmpeg/build"
if [ -z "$2" ]; then
  ./copy_ffmpeg.bat $dirName
else
  ./copy_ffmpeg.bat $dirName $2
fi