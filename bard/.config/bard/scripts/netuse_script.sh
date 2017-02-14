#!/bin/bash
collectl -sN -oG -i15 --hr -1 | grep --line-buffered "wlp3s0b1"
