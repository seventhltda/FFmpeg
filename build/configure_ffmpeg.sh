# Function to apply a patch file on libmp3lame
apply_patch() {
  local url=$1
  local patch_type=$2
  if [[ -z $patch_type ]]; then
    patch_type="-p0"
  fi
  local patch_name=$(basename $url)
  local patch_done_name="$patch_name.done"
  if [[ ! -e $patch_done_name ]]; then
    if [[ -f $patch_name ]]; then
      rm $patch_name || exit 1 # remove old version in case it has been since updated
    fi
    # Instead of downloading (from https://raw.githubusercontent.com/rdp/ffmpeg-windows-build-helpers/master/patches/lame3.patch), copy from local file
    # curl -4 $url -O || exit 1
    cp $url $patch_name
    patch $patch_type < "$patch_name" || exit 1
    touch $patch_done_name || exit 1
  else
    echo "patch $patch_name already applied"
  fi
}

# Deletes any pre-existing files and copies the libmp3lame source from the dependencies
rm -rf lame-3.99.5
rm -f lame-3.99.5.tar.gz
cp "D:/FFmpeg/dependencies/libmp3lame/lame-3.99.5.tar.gz" lame-3.99.5.tar.gz

# Unpacks
tar xvfz lame-3.99.5.tar.gz
cd ~/lame-3.99.5

# Apply the patch (again, from dependencies)
apply_patch "D:/FFmpeg/dependencies/libmp3lame/lame3.patch"

# Configure libmp3lame according to the architecture
if [ $1 = x86 ]; then
  ./configure --prefix="C:/msys64/mingw32/i686-w64-mingw32" --host=i686-w64-mingw32 --enable-static --disable-shared
fi

if [ $1 = x86_64 ]; then
  ./configure --prefix="C:/msys64/mingw64/x86_64-w64-mingw32" --host=x86_64-w64-mingw32 --enable-static --disable-shared
fi

# Build libmp3lame
make clean && make -j4
make install

# Deletes any pre-existing files and copies the libx264 source from the dependencies
rm -rf x264-20170123-90a61ec
rm -f x264-20170123-90a61ec.tar.xz
cp "D:/FFmpeg/dependencies/libx264/x264-20170123-90a61ec.tar.xz" x264-20170123-90a61ec.tar.xz

# Unpacks
tar xf x264-20170123-90a61ec.tar.xz
cd ~/x264-20170123-90a61ec

# Apply the patch (again, from dependencies)
echo 'There are no patches for libx264'

# Configure libx264 according to the architecture
if [ $1 = x86 ]; then
  ./configure --prefix="C:/msys64/mingw32/i686-w64-mingw32" --host=i686-w64-mingw32 --enable-static
fi

if [ $1 = x86_64 ]; then
  ./configure --prefix="C:/msys64/mingw64/x86_64-w64-mingw32" --host=x86_64-w64-mingw32 --enable-static
fi

# Build libx264
make clean && make
make install

# Navigate to the project workspace (FFmpeg root source directory) and configure FFmpeg
cd "D:/FFmpeg/"

make distclean
make clean

if [ $1 = x86 ]; then
  ldflags="-static -L/c/msys64/mingw32/i686-w64-mingw32"
fi

if [ $1 = x86_64 ]; then
  ldflags="-static -L/c/msys64/mingw64/x86_64-w64-mingw32/lib"
fi

flags="--disable-everything --disable-debug --pkg-config=pkg-config"
flags="$flags --enable-ffmpeg --enable-ffplay"
flags="$flags --enable-zlib --enable-small --optflags=-O2"
flags="$flags --enable-yasm --enable-asm --enable-hwaccels"
flags="$flags --enable-shared --enable-memalign-hack"
flags="$flags --enable-gpl --enable-nonfree --enable-libx264 --enable-libmp3lame"
flags="$flags --enable-protocol=concat --enable-protocol=file"
flags="$flags --enable-filter=color --enable-filter=smptebars --enable-filter=testsrc --enable-filter=nullsrc"
flags="$flags --enable-filter=anullsrc --enable-filter=anoisesrc --enable-filter=aevalsrc"
flags="$flags --enable-filter=fps --enable-filter=subtitles --enable-filter=aresample"
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
Enable aac           n y n y n
Enable ac3           y y y y y
Enable adpcm_ct      n y n n n
Enable adpcm_g726    n y n n n
Enable adpcm_ima_apc n y n n n
Enable h264          n y y y y
Enable libx264       y n n n n
Enable hevc          n y y y y
Enable libmp3lame    y n n n n
Enable m4v           n n y y n
Enable mjpeg         y y y y y
Enable mpegts        n n y y n
Enable movtext       y y n n n
Enable mp3           n y y y n
Enable mp4           n n y n n
Enable mpeg4         n y n n n
Enable mov           n n y y n
Enable pcm_alaw      y y n y n
Enable pcm_mulaw     n y n y n
Enable pcm_u8        y y y y n
Enable png           y y n n y
Enable rawvideo      y y y y n
Enable srt           y y y y n
Enable subrip        y y n n n

./configure --extra-ldflags="$ldflags" $flags

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