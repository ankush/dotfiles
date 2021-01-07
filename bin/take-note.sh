#!/bin/bash

nvim -c "+VimwikiMakeDiaryNote" \
  -c "norm Go$(date '+%I:%M %p'):  " \
  -c "startinsert"
