#!/bin/bash
today=$(date -I'date')

rg '\[ \]' ~/wiki/diary/$(echo $today).md | cut -c2-
