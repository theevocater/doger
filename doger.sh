#!/bin/bash

word_list="fluff doge haha cute deog shibe"

prefix_list=( so much very such )

word_list="$word_list wow wow wow"
word_list_size=${#prefix_list[@]}

point_size=18
font="/Library/Fonts/Comic Sans MS.ttf"
color="rgb(0,0,255)"
input_image="odoge.jpg"
output_image="out.jpg"
geometry=`gm identify odoge.jpg | cut -d" " -f3 | cut -d"+" -f1`
width=`cut -d"x" -f1 <<< $geometry`
height=`cut -d"x" -f2 <<< $geometry`
w_border=$((${width}/10))
h_border=$((${height}/10))
echo ${width}x${height}
echo ${w_border}x${h_border}

function edit_image() {
  gm convert -font "$font" -pointsize "$point_size" -fill "$color" -draw "$draw" "$input_image" "$output_image"
}

function randomize_color() {
  # 255 is the highest color but I'm leaving out values between 0-25 and
  # 230-255 to leave out too dark or too light colors
  r=$((${RANDOM}%(255-50)+25))
  g=$((${RANDOM}%(255-50)+25))
  b=$((${RANDOM}%(255-50)+25))

  # mix with white to create pastels
  r=$((${r}+255/2))
  g=$((${g}+255/2))
  b=$((${b}+255/2))

  color="rgb($r,$g,$b)"
}

function randomize_location() {
  x=$((${RANDOM}%(${width}-2*${w_border})+${w_border}))
  y=$((${RANDOM}%(${height}-2*${h_border})+${h_border}))

  location="${x},${y}"
}

function choose_prefix() {
  index=$((${RANDOM}%${word_list_size}))
  prefix=${prefix_list[${index}]}
}

for word in $word_list
do
randomize_location
randomize_color
choose_prefix
word="\"$prefix $word\""
draw="text $location $word"
echo "Adding $draw $color"
edit_image
input_image="$output_image"
done
