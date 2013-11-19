#!/bin/bash

point_size=18
font="/Library/Fonts/Comic Sans MS.ttf" 
color="rgb(0,0,255)"
input_image="odoge.jpg"
output_image="out.jpg"

function edit_image() {
  gm convert -font "$font" -pointsize "$point_size" -fill "$color" -draw "$draw" "$input_image" "$output_image"
}

function randomize_color() {
  r=$((${RANDOM}%255))
  g=$((${RANDOM}%255))
  b=$((${RANDOM}%255))
  color="rgb($r,$g,$b)"
}

location="100,100"
word="wow"
draw="text $location $word" 
edit_image

input_image="$output_image"

location="200,200"
word="wow"
draw="text $location $word" 
randomize_color
edit_image

location="300,300"
word="wow"
draw="text $location $word" 
randomize_color
edit_image

