#!/bin/bash

point_size=18
font="/Library/Fonts/Comic Sans MS.ttf" 
color="rgb(0,0,255)"
input_image="odoge.jpg"
output_image="out.jpg"
geometry=`gm identify odoge.jpg | cut -d" " -f3 | cut -d"+" -f1`
width=`cut -d"x" -f1 <<< $geometry`
height=`cut -d"x" -f2 <<< $geometry`
echo ${width}x${height}

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
  x=$((${RANDOM}%${width}))
  y=$((${RANDOM}%${height}))

  location="${x},${y}"
}

randomize_location
word="wow"
draw="text $location $word" 
edit_image

input_image="$output_image"

randomize_location
word="wow"
draw="text $location $word" 
randomize_color
edit_image

randomize_location
word="wow"
draw="text $location $word" 
randomize_color
edit_image

