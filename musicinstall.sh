#!/bin/bash
set -e

last_url=""

while true; do
  echo ""
  echo "--------------------------------------------------------"
  echo "ENTER URL TO PLAYLIST OR SONG"
  echo "--------------------------------------------------------"
  echo "(type 'r' to repeat last, 'q' to quit)"
  echo "--------------------------------------------------------"
  echo ""

  read -p "-->" URL

  # Handle quitting
  if [[ "$URL" == "q" || "$URL" == "Q" ]]; then
    echo ""
    echo "--------------------------------------------------------"
    echo "EXITING"
    echo "--------------------------------------------------------"
    echo ""
    break
  fi

  # Handle empty input
  if [ -z "$URL" ]; then
    echo "------------------------------------------------------"
    echo "No URL entered"
    echo "------------------------------------------------------"
    continue
  fi

  # Handle "rerun last"
  if [[ "$URL" == "r" || "$URL" == "R" ]]; then
    if [ -z "$last_url" ]; then
      echo "------------------------------------------------------"
      echo "No URL to repeat"
      echo "------------------------------------------------------"
      continue
    else
      echo "------------------------------------------------------"
      echo "Installing last: $last_url"
      echo "------------------------------------------------------"
      URL="$last_url"
    fi
  else
    # Store current input as last_url
    last_url="$URL"
  fi

  echo ""
  echo "--------------------------------------------------------"
  echo "DOWNLOADING"
  echo "--------------------------------------------------------"
  echo ""

  spotdl --output "./Music/{artist}/{album}/{title}.mp3" "$URL"

  echo ""
  echo "--------------------------------------------------------"
  echo "DOWNLOAD COMPLETE"
  echo "--------------------------------------------------------"

  echo ""
  echo "Continue? (y/n)"
  read -p "-->" answer
  if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
    echo ""
    echo "--------------------------------------------------------"
    echo "EXITING"
    echo "--------------------------------------------------------"
    echo ""
    break
  fi
done
