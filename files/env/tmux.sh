#!/bin/bash

tmux -2 new-session -d -s libreforge

# CREATE FRONT WINDOW
tmux rename-window -t libreforge:0 'back'
tmux send-keys -t libreforge 'cd' C-m

# CREATE BACK WINDOW
tmux new-window -t libreforge:1 -n 'front'
tmux select-window -t libreforge:1
tmux send-keys -t libreforge 'cd' C-m

# CREATE DATABASE SHELL WINDOW
tmux new-window -t libreforge:2 -n 'db'
tmux select-window -t libreforge:2
tmux send-keys -t libreforge 'cd' C-m

tmux -2 attach-session -t libreforge
