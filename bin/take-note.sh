#!/bin/bash

# Exit if window exists
ps -eaf | rg "[V]imwikiMakeDiaryNote" && exit

nvim -c "+VimwikiMakeDiaryNote"
