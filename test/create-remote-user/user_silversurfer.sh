#!/usr/bin/env bash

source dev-container-features-test-lib
source test_functions.sh

check "configured user should exist" assert_user_exists "silversurfer"

reportResults