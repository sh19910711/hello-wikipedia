#!/bin/bash

cat tmp/rank.txt | \
  grep -v '^[0-9]\{1,4\}年$' | \
  grep -v '^[0-9]\{1,2\}月[0-9]\{1,2\}日$'

