#!/bin/bash

REPO=~/'My Notes'/Notes

git -C "$REPO" add .

if git -C "$REPO" diff --cached --quiet; then
  echo "No new Notes written to commit."
  exit 0
fi

git -C "$REPO" commit -m "note update"
git -C "$REPO" push
