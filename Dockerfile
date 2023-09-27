FROM dperson/samba:latest

RUN apk add --no-cache openssl xxd

COPY entrypoint.sh gen_hashes.sh passwd_tools.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh /usr/bin/gen_hashes.sh /usr/bin/passwd_tools.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh"]