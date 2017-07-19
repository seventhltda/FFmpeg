# Navigate to the project workspace (FFmpeg root source directory) and configure FFmpeg
cd "D:/FFmpeg/"

make distclean
make clean

ldflags="-static"

flags="--disable-everything --disable-debug --disable-network"
flags="$flags --pkg-config=pkg-config --enable-ffmpeg --enable-ffplay"
flags="$flags --enable-zlib --enable-small --optflags=-O2"
flags="$flags --enable-yasm --enable-asm --enable-hwaccels"
flags="$flags --enable-shared --enable-memalign-hack"
flags="$flags --enable-gpl --enable-nonfree --enable-protocol=file"
flags="$flags --enable-cross-compile --arch=$1 --target-os=mingw32"

function Enable {
  if [ $2 = y ]; then
    flags="$flags --enable-encoder=$1"
  fi

  if [ $3 = y ]; then
    flags="$flags --enable-decoder=$1"
  fi

  if [ $4 = y ]; then
    flags="$flags --enable-muxer=$1"
  fi

  if [ $5 = y ]; then
    flags="$flags --enable-demuxer=$1"
  fi

  if [ $6 = y ]; then
    flags="$flags --enable-parser=$1"
  fi
}

# Format - (E)ncoder, (D)ecoder, (M)uxer, Demu(X)er, (P)arser
#      Format        E D M X P
Enable aac           y y n y y
Enable adpcm_ct      n y n n n
Enable adpcm_g726    y y n n n
Enable adpcm_ima_apc n y n n n
Enable h264          n y n y y
Enable hevc          n y n y y
Enable m4v           n n n y n
Enable mjpeg         n y n y y
Enable mpeg1video    n y n n n
Enable mpeg2video    n y n n n
Enable mpeg4         n y n n n
Enable mpegps        n n n y n
Enable mpegts        n n n y n
Enable mpegtsraw     n n n y n
Enable mpegvideo     n y n y y
Enable pcm_alaw      y y n y n
Enable pcm_mulaw     y y n y n

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