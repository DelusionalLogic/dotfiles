#!/bin/bash

echo $2 | awk -v len=80 '{ if (length($0) > len) print substr($0, 1, len-3) "..."; else print; }'
