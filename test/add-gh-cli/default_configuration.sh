#!/usr/bin/env bash

source dev-container-features-test-lib
source test_functions.sh

check "gh cli shout exist" assert_software_installed "gh"

reportResults