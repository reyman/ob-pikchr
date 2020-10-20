#!/bin/bash
wget https://pikchr.org/home/tarball/b1d01d99f9/pikchr-b1d01d99f9.tar.gz

[[ -d pikchr-latest ]] && rm -r pikchr-latest

mkdir pikchr-latest
tar -zxvf pikchr-b1d01d99f9.tar.gz -C pikchr-latest


