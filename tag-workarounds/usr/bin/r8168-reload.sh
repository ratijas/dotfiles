#!/bin/sh

# Fix ethernet port voiding out after sleep

rmmod    r8168
modprobe r8168
