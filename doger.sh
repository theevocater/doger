#!/bin/bash

echo $#
if [[ ${#} < 2 ]]
then
  echo "$0 filename.jpg word list ..."
  exit -1
fi

input_image=$1
shift
word_list=$*

prefix_list=( so much very such )
prefix_list_size=${#prefix_list[@]}

point_size=18
font="/Library/Fonts/Comic Sans MS.ttf"
color="rgb(0,0,255)"

# use png as the "scratch image" to keep quality up
temp_image="scratch.png"

# get geometry of image
geometry=`gm identify "${input_image}" | cut -d" " -f3 | cut -d"+" -f1`
width=`cut -d"x" -f1 <<< $geometry`
height=`cut -d"x" -f2 <<< $geometry`
w_border=$((${width}/10))
h_border=$((${height}/10))
echo $input_image
echo $temp_image
echo ${width}x${height}
echo ${w_border}x${h_border}

function edit_image() {
  gm convert -font "$font" -pointsize "$point_size" -fill "$color" -draw "$draw" "$temp_image" "$temp_image"
}

function randomize_color() {
  # 255 is the highest color but I'm leaving out values between 0-34 and
  # 246-255 to leave out too dark or too light colors
  r=$((${RANDOM}%(255-50)+35))
  g=$((${RANDOM}%(255-50)+35))
  b=$((${RANDOM}%(255-50)+35))

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
  index=$((${RANDOM}%${prefix_list_size}))
  prefix=${prefix_list[${index}]}
}

# create the scratch file
gm convert "$input_image" "$temp_image"

# add all the words from the input list
for word in $word_list
do
randomize_location
randomize_color
choose_prefix
word="\"$prefix $word\""
draw="text $location $word"
echo "Adding $draw $color"
edit_image
done

# add a few wows for good measure
for word in wow wow wow wow
do
randomize_location
randomize_color
draw="text $location $word"
echo "Adding $draw $color"
edit_image
done

# output to the original filetype
output_image="out.${input_image#*\.}"
echo $output_image
gm convert -quality 100 "$temp_image" "$output_image"
# delete scratch
rm "${temp_image}"

# TODO
# * add random e to the end of words without e
# * use prefix only once
