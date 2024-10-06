#!/usr/bin/env bash

set -e

source functions.sh

if [ "$_REMOTE_USER" = "root" ]; then
  echo "Detected root as the remote user - exiting installation."
  exit 0
else
  echo "Continuing installation for user $_REMOTE_USER"
fi

# Create the new user
echo "Creating user $_REMOTE_USER with UID $USER_UID and GID $USER_GID..."
useradd -m -u "$USER_UID" -g "$USER_GID" "$_REMOTE_USER" && \
echo "$_REMOTE_USER:$_REMOTE_USER" | chpasswd

# Set home directory permissions
chown -R "$_REMOTE_USER:$_REMOTE_USER" /home/"$_REMOTE_USER"

# Add user to sudo group
if ! id -nG "$_REMOTE_USER" | grep -qw "sudo"; then
  echo "User is not in group 'sudo' - adding user to sudo"
  usermod -a -G sudo "$_REMOTE_USER"
fi

# Install sudo if not present
if ! which sudo; then
  echo "sudo is not installed - starting installation"
  check_and_install sudo
fi

# Cleanup
clean_package_cache
