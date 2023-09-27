#!/bin/bash

source /usr/bin/passwd_tools.sh

get_secrets

smbpasswd -x admin 2>/dev/null 1>/dev/null || true
userdel -r admin 2>/dev/null 1>/dev/null || true

useradd -p "${ADMIN_PASSWORD_CRYPT}" admin
smbpasswd -a -U admin -n
pdbedit --modify -u admin --set-nt-hash "${ADMIN_PASSWORD_NT_HASH}" 2>/dev/null 1>/dev/null
pdbedit -c D -u admin 2>/dev/null 1>/dev/null

/usr/bin/samba.sh -s "srv;/srv;yes;no;no;admin;admin" -G "global;server min protocol = SMB3_02" -G "srv;smb encrypt = required"
