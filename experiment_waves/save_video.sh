time_stamp="$1"
pathPrefix="$2"
ffmpeg_path="$3"

pwd
cd "$pathPrefix"frames/"$time_stamp"/

"$ffmpeg_path" -framerate 30 -i %d.png -c:v libx264 -pix_fmt yuv420p ../"$time_stamp".mp4
