#!/usr/bin/env bash

assert_user_exists() {
  if ! id "$1"; then
    exit 1
  fi
}

assert_user_is_in_group() {
  if ! id -nG "$1" | grep -qw "$2"; then
    exit 1
  fi
}

assert_user_is_not_in_group() {
  if id -nG "$1" | grep -qw "$2"; then
    exit 1
  fi
}

assert_command_is_available() {
  if ! which "$1"; then
    exit 1
  fi
}

assert_command_is_not_available() {
  if which "$1"; then
    exit 1
  fi
}

assert_password_is_set() {
  id
  if ! echo "$2" | sudo -S -l; then
    exit 1
  fi
}

assert_password_is_not_set() {
  if ! sudo -S -l <<< "$1" > /dev/null 2>&1; then
    return 0  # Password is not set
  else
    return 1  # Password is set
  fi
}

assert_software_installed() {
  if ! command -v "$1" &> /dev/null; then
    echo "$1 is not installed."
    exit 1
  else
    echo "$1 is installed."
  fi
}