#!/bin/sh
set -e

USER_UID="${USER_UID:-"7009"}"
USER_GID="${USER_GID:-"7009"}"
_REMOTE_USER="jully"

source functions.sh

if [ "$_REMOTE_USER" = "root" ]; then
  echo "Detected root as the remote user - exiting installation."
  exit 0
else
  echo "Continuing installation for user $_REMOTE_USER"
fi

# Delete conflicting user 
if id -u $USER_UID > /dev/null ; then 
  CONFLICTING_USER=$(getent group "$USER_UID" | cut -d: -f1)
  echo "UID '$USER_UID' is used by user '$CONFLICTING_USER'. Deleting '$CONFLICTING_USER'..."
  userdel $(id -un $USER_UID) ;
fi

# Create the group
echo "Creating group $_REMOTE_USER with GID $USER_GID..."
groupadd --gid $USER_GID $_REMOTE_USER

# Create the new user
echo "Creating user $_REMOTE_USER with UID $USER_UID and GID $USER_GID..."
useradd -u "$USER_UID" -g "$USER_GID" -M "$_REMOTE_USER" && \
echo "$_REMOTE_USER:$_REMOTE_USER" | chpasswd

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
