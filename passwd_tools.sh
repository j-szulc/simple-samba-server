#!/bin/bash

ntlm_hash () {
  # Source: https://blog.atucom.net/2012/10/generate-ntlm-hashes-via-command-line.html
  iconv -f ASCII -t UTF-16LE <(printf "${1}") | openssl dgst -md4 -binary | xxd -p
}

unix_crypt() {
  mkpasswd -m sha-512 "$1"
}

get_secrets() {
  # If no ADMIN_PASSWORD_PLAINTEXT, ADMIN_PASSWORD_NT_HASH, ADMIN_PASSWORD_CRYPT set, ask for one
  if [ -z "${ADMIN_PASSWORD_PLAINTEXT}" ] && [ -z "${ADMIN_PASSWORD_NT_HASH}" ] && [ -z "${ADMIN_PASSWORD_CRYPT}" ]; then
    read -s -p "Enter Password: " ADMIN_PASSWORD_PLAINTEXT
    echo
    read -s -p "Confirm Password: " ADMIN_PASSWORD_PLAINTEXT2
    echo

    if [ "${ADMIN_PASSWORD_PLAINTEXT}" != "${ADMIN_PASSWORD_PLAINTEXT2}" ]; then
      echo "Passwords do not match"
      exit 1
    fi
  fi

  # If set ADMIN_PASSWORD_PLAINTEXT generate hashes
  if [ -n "${ADMIN_PASSWORD_PLAINTEXT}" ]; then
    export ADMIN_PASSWORD_NT_HASH=$(ntlm_hash "${ADMIN_PASSWORD_PLAINTEXT}")
    export ADMIN_PASSWORD_CRYPT=$(unix_crypt "${ADMIN_PASSWORD_PLAINTEXT}")
  fi

  if [ -z "${ADMIN_PASSWORD_NT_HASH}" ] || [ -z "${ADMIN_PASSWORD_CRYPT}" ]; then
    echo "ADMIN_PASSWORD_NT_HASH and ADMIN_PASSWORD_CRYPT must be set"
    exit 1
  fi
}
