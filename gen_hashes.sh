#!/bin/bash

source /usr/bin/passwd_tools.sh

get_secrets

echo "ADMIN_PASSWORD_NT_HASH: ${ADMIN_PASSWORD_NT_HASH}"
echo "ADMIN_PASSWORD_CRYPT: ${ADMIN_PASSWORD_CRYPT}"