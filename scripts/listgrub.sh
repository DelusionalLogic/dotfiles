#!/bin/bash
cat /boot/grub/grub.cfg | grep -i "^menuentry" | cut -d"'" -f2
