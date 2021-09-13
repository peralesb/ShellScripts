#!/bin/bash

#while true; do { echo -e 'HTTP/1.1 200 OK\r\n'; sh test.sh;  } | nc -l 9037; done
while true; do { echo -e "HTTP/1.1 200 OK\r\n$(date)\r\n\r\n<h1>hello world from $(hostname) on $(date)</h1>" |  nc -l 9037; } done
