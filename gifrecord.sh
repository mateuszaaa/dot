#!/bin/bash

DIR=$(mktemp -d)
STOP_LOOP=false

cleanup() {
  STOP_LOOP=true
}

GEOMETRY=$(slurp)
trap cleanup INT

main() {

  let i=0

  while [ "$STOP_LOOP" = false ]; do
    echo "Running loop..."
    grim -g "$GEOMETRY" $DIR/$(printf "%04d" $i).png
    ((i = i + 1)) # Increment i
    ls -la $DIR/
    sleep 0.05
  done

  echo "Exited the loop."

  ffmpeg -framerate 10 -i $DIR/%04d.png /tmp/ss.gif
}

# Execute main function
main
