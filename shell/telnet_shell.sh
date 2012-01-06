#!/bin/bash
(sleep 1
echo "default"
sleep 20
)|telnet -l admin $1
