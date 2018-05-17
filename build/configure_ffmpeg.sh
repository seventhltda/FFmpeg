# Navigate to the project workspace (FFmpeg root source directory) and configure FFmpeg
cd "D:/FFmpeg/"

make distclean
make clean

ldflags="-static"

flags="--disable-everything --disable-debug --pkg-config=pkg-config"
flags="$flags --enable-ffmpeg --enable-ffplay"
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
Enable ac3           y y y y y
Enable adpcm_ct      n y n n n
Enable adpcm_g726    y y n n n
Enable adpcm_ima_apc n y n n n
Enable concat        n n n y n
Enable dash          n n y n n
Enable h264          n y y y y
Enable libx264       y n n n n
Enable hevc          n y y y y
Enable libmp3lame    y n n n n
Enable m4v           n n y y n
Enable mjpeg         y y y y y
Enable mpeg1video    n y n n n
Enable mpeg2video    n y n n n
Enable mpeg4         n y n n n
Enable mpegps        n n n y n
Enable mpegts        n n y y n
Enable mpegtsraw     n n n y n
Enable mpegvideo     n y n y y
Enable movtext       y y n n n
Enable mp3           n y y y n
Enable mp4           n n y n n
Enable mpeg4         n y n n n
Enable mov           n n y y n
Enable pcm_alaw      y y n y n
Enable pcm_mulaw     y y n y n
Enable pcm_u8        y y y y n
Enable png           y y n n y
Enable rawvideo      y y y y n
Enable rtsp          n n y y n
Enable srt           y y y y n
Enable subrip        y y n n n

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