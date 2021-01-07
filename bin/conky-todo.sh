#!/bin/bash

rg -v '\[X\]' "$HOME/wiki/diary/$(date -I'date').md"
