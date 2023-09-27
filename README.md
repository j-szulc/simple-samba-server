# Simple Samba server container
Fork of https://github.com/dperson/samba
## Usage:
1. Build image:
```sh
docker build -t simple-samba .
```
2. Either:
    - Provide password in plaintext
        ```sh
        docker run --rm -d \
          -v /folder/to/share:/srv \
          -p 139:139 \
          -p 445:445 \
          -e ADMIN_PASSWORD_PLAINTEXT=password \
          --name samba \
          simple-samba
        ```
    - Provide password as hash:
        ```sh
        docker run --rm -it --entrypoint /usr/bin/gen_hashes.sh simple-samba
        # Copy hashes from output
        docker run --rm -d \
          -v /folder/to/share:/srv \
          -p 139:139 \
          -p 445:445 \
          -e ADMIN_PASSWORD_NT_HASH=... \
          -e ADMIN_PASSWORD_CRYPT=... \
          --name samba \
          simple-samba
      ```
3. Connect to `smb://admin@<host>/srv`