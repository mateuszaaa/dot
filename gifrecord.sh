#!/bin/bash

DIR=$(mktemp -d)
STOP_LOOP=false

cleanup() {
  STOP_LOOP=true
}

GEOMETRY=$(slurp)
trap cleanup INT

main() {
  notify-send 'start recording, middle-click to stop',

  let i=0

  while [ "$STOP_LOOP" = false ]; do
    grim -g "$GEOMETRY" $DIR/$(printf "%04d" $i).png
    convert $DIR/$(printf "%04d" $i).png -colors 128 $DIR/$(printf "%04d" $i).png
    ((i = i + 1)) # Increment i
    sleep 0.2
  done

  rm -rf /tmp/ss.gif || true
  ffmpeg -framerate "5" -i "$DIR"/%04d.png -vf "palettegen" $DIR/palette.png
  ffmpeg -framerate "5" -i "$DIR"/%04d.png -i $DIR/palette.png -lavfi "paletteuse=dither=bayer" -r 10 $DIR/ss.gif
  cp $DIR/ss.gif /tmp/ss.gif
  wl-copy --type image/gif </tmp/ss.gif
  notify-send "/tmp/ss.gif copied to clipboard"

}

# Execute main function
main
