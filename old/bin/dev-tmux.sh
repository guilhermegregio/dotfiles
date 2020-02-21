#!/bin/sh

tmux rename-window Front
tmux split-window -d -t 1 -h
tmux split-window -d -t 2 -v

tmux send-keys -t 1 'cd ~/Documentos' enter C-1
tmux send-keys -t 1 'ls -lh' enter C-1
