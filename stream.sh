#! /bin/bash                                                 
                                                            # Скачать нужно: npm i shelljs и pm2 
                                                            # npm init
                                                            # При запуске прописывать - chmod +x stream.sh и chmod 777 stream.sh
                                                            # Создаете папку radio и закидываете туда любое видио ЕСЛИ КИДАТЬ 2 ВИДИО ТО ОНИ ДОЛЖНЫ БЫТЬ ОДНОГО РАЗРЕШЕНИЯ!
VBR="4000k"                                                 # Битрейт видео
FPS="60"                                                    # FPS
QUAL="medium"                                               # Пресет качества для FFmpeg
TWITCH_URL=""                                               # URL RTMP Twitch
KEY="live_517990921_gOBVnOCrrRtWtI6t98Ad8aZJNAHsxQ"         # Ключ потока
FOLDER="radio"                                              # Имя папки с видео роликами


SOURCE=""
n=0
filter="" 
for f in $FOLDER/*.mp4
do
  SOURCE="$SOURCE -i $f"
  filter="$filter [$n:v:0] [$n:a:0]"
  ((n++))
done

filter="$filter concat=n=$n:v=1:a=1 [v] [a]"

echo "ffmpeg $SOURCE -filter_complex '$filter'"

ffmpeg \
    $SOURCE -filter_complex "$filter" \
-map "[v]" -map "[a]" -deinterlace \
    -vcodec libx264 -pix_fmt yuv420p -preset $QUAL -r $FPS -g $(($FPS * 2)) -b:v $VBR \
    -acodec libmp3lame -ar 44100 -threads 6 -qscale 3 -b:a 712000 -bufsize 512k \
    -f flv "$TWITCH_URL/$KEY"
