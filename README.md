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
2. Change `/folder/to/serve` in `docker-compose.yml` to folder you want to share.
3. Run
    ```sh
    docker-compose up -d --build`
    ```
4. Mount `smb://admin@<docker host ip>:/srv`.