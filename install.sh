#!/bin/sh

echo "Installing crystal shell..."
crystal build crystal_shell.cr -o /usr/local/bin/crystal_shell --release