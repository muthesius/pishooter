#!/usr/bin/env sh

USER=root
IP="10.2.242.247"
NAME=$1
NUM_IMAGES=$2
SLEEP=5

# Check if project exists
if [[ -d "./$NAME" ]]; then
  echo "ups, project exists. please use a different name."
  exit
fi

if [[ "$NAME" == "" ]]; then
  echo "No project name!! use as such: ./pishot.sh <some-name> <num-images>"
  exit
fi

if [[ "$NUM_IMAGES" == "" ]]; then
  NUM_IMAGES=120
  echo "Using default $NUM_IMAGES as default. To change the number of images, use as such: ./pishot.sh <some-name> <num-images>"
fi

mkdir -p $NAME

count=`ls -1 $NAME|wc -l`
count=$((count+1))

_filename=$NAME/shot-$count

# single shot
# echo "************************"
# echo Getting image $_filename
# touch $_filename
# # ssh $USER@${IP} raspistill -n -o - > $_filename.jpeg
# echo "****** DONE  ***********"

# # auto sequence:
echo "will take $NUM_IMAGES images.. this may take while..."
for i in $(seq 1 $NUM_IMAGES); do
  _filename=$NAME/shot-$count
  echo "************************"
  echo Getting image $i
  ssh $USER@${IP} raspistill -n -o - > $_filename.jpeg
  echo "****** DONE  ***********"
  read -s -n 1 -p "Press any key for next image (Escape or Control-C to exit)" key
  case $key in
     $'\e') echo "\nQuitting... bye, bye!"; exit;;
 esac
done

