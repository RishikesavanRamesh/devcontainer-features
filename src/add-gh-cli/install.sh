#!/usr/bin/env bash

set -e

source functions.sh

# Check and install wget if not present
echo "Checking for wget..."
check_and_install wget

# Set up GitHub CLI repository
echo "Setting up GitHub CLI repository..."
mkdir -p -m 755 /etc/apt/keyrings
wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null
echo "GitHub CLI repository added successfully."

# Update package list and install GitHub CLI
echo "Installing GitHub CLI..."
check_and_install gh

# Cleanup
echo "Cleaning up package cache..."
clean_package_cache
echo "Github Cli Installation and setup completed successfully."