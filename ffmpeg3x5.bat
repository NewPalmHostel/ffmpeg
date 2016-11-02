@echo off
cd /d %~dp0

set fps=50

for %%n in (apple,banana,chocolate) do (
    for %%i in (1,2,3,4,5) do (
    	ffmpeg -r %fps% -i %%n_no%%i_%%05d.png -vcodec libx264 -pix_fmt yuv420p %%n_no%%i.mp4
    )
)

for %%i in (1,2,3,4,5) do (
    ffmpeg -i apple_no%%i.mp4 -i chocolate_no%%i.mp4 -i banana_no%%i.mp4 -filter_complex "vstack=inputs=3" -vcodec libx264 -pix_fmt yuv420p stack_no%%i.mp4
)

ffmpeg -i stack_no1.mp4 -i stack_no2.mp4 -i stack_no3.mp4 -i stack_no4.mp4 -i stack_no5.mp4  -filter_complex "hstack=inputs=5" -vcodec libx264 -pix_fmt yuv420p stack_nos.mp4

