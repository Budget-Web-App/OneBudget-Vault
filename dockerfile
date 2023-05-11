FROM vault:latest

COPY vault.hcl /vault/data/vault.hcl

EXPOSE 8200

CMD vault server -dev -config /vault/data/vault.hcl