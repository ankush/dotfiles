#!/bin/bash

rg '\[' "$HOME/wiki/diary/$(date -I'date').md" | cut -c2-
