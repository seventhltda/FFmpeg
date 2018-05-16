# Navigate to the project workspace (FFmpeg root source directory) and configure FFmpeg
cd "D:/FFmpeg/"

make distclean
make clean

ldflags="-static"

flags="--enable-shared --enable-static"
flags="$flags --pkg-config=pkg-config --enable-ffmpeg --enable-ffplay"
flags="$flags --enable-zlib --enable-small --optflags=-O2"
flags="$flags --enable-yasm --enable-asm --enable-hwaccels"
flags="$flags --enable-shared --enable-memalign-hack"
flags="$flags --enable-gpl --enable-nonfree --enable-protocol=file"
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