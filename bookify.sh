#!/usr/bin/bash

[[ -e $1 ]] && arg=$1 || arg="adamuv_zpevnik_tisk.pdf"

pdfbook --booklet true $arg
