FROM vault:latest

COPY vault.hcl /vault/data/vault.hcl

CMD vault server -dev -config /vault/data/vault.hcl