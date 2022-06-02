#!/bin/bash
for a in $(docker ps -aq)
  do
    docker rm -f $a
  done 
