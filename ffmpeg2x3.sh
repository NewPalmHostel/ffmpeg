#!/bin/sh

### fps=50
fps=25

# echo "alpha"
for cnt in 1 2 3; do
    ffmpeg -r ${fps} -i ./alpha/${cnt}obj/img%03d.png -vcodec libx264 -pix_fmt yuv420p a${cnt}f${fps}.mp4
done

ffmpeg -i a1f${fps}.mp4 -i a2f${fps}.mp4 -i a3f${fps}.mp4 -filter_complex "[0:v][1:v]hstack[tmp1];[tmp1][2:v]hstack[out]" -map "[out]" -vcodec libx264 -pix_fmt yuv420p alpha${fps}.mp4

# echo "beta"
for cnt in 1 2 3; do
    ffmpeg -r ${fps} -i ./beta/${cnt}obj/img%03d.png -vcodec libx264 -pix_fmt yuv420p b${cnt}f${fps}.mp4
done

ffmpeg -i b1f${fps}.mp4 -i b2f${fps}.mp4 -i b3f${fps}.mp4 -filter_complex "[0:v][1:v]hstack[tmp1];[tmp1][2:v]hstack[out]" -map "[out]" -vcodec libx264 -pix_fmt yuv420p beta${fps}.mp4

# # echo "all"
ffmpeg -i alpha${fps}.mp4 -i beta${fps}.mp4 -filter_complex vstack -vcodec libx264 -pix_fmt yuv420p all${fps}.mp4

