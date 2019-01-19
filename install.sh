#!/bin/sh

echo "Installing crystal shell..." && \
curl --silent https://raw.githubusercontent.com/anykeyh/crystal-shell/master/crystal_shell.cr > .tmp_download_crystal_shell.cr && \
crystal build .tmp_download_crystal_shell.cr -o /usr/local/bin/crystal_shell --release && \
rm .tmp_download_crystal_shell.cr && \
echo "Done ! :-)"