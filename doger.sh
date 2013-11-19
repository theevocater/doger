#!/bin/bash

word_list="fluff doge haha cute deog shibe"

prefix_list=( so much very such )

word_list="$word_list wow wow wow"

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
  r=$((${RANDOM}%255))
  g=$((${RANDOM}%255))
  b=$((${RANDOM}%255))
  color="rgb($r,$g,$b)"
}

function randomize_location() {
  x=$((${RANDOM}%(${width}-2*${w_border})+${w_border}))
  y=$((${RANDOM}%(${height}-2*${h_border})+${h_border}))

  location="${x},${y}"
}

for word in $word_list
do
randomize_location
randomize_color
draw="text $location $word"
echo "Adding $word at $draw"
edit_image
input_image="$output_image"
done
