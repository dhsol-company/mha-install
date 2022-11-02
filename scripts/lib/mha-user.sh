#!/bin/bash

# MUST be run as mha!

set -e

echo "Adding to PATH."
echo "export PATH=$PATH:/usr/local/bin:/usr/local/mysql/bin" >>~/.bash_profile
source ~/.bash_profile

echo "Generating ssh key."
ssh-keygen -t rsa -b 4096

echo "Sending copies to servers."
ssh-copy-id mha@mha
ssh-copy-id mha@db-1
ssh-copy-id mha@db-2
