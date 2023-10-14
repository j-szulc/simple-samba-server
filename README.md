# Simple Samba server container
Fork of https://github.com/dperson/samba
## Usage:
1. Create samba.env from samba.env.example
   - By default password is `test`.
   - To change it paste env variable obtained from:
       ```sh
       docker-compose run --build --rm samba-gen-hashes
       ```
     to `samba.env`.
3. Create .env from .env.example
    - Choose folder to serve
4. Run
    ```sh
    docker-compose up -d --build`
    ```
4. Mount `smb://admin@<docker host ip>`.
