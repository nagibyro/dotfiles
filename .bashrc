#!/bin/bash
for i in ~/.bashrc.d/*.sh; do
    . "$i"
done; unset i
