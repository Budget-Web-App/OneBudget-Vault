FROM hashicorp/vault:latest

# Make needed directories
RUN mkdir -p /vault/config /vault/data /vault/log &&\ 
    chmod 777 /vault/data

# Copy Vault configuration file
COPY vault.hcl /vault/config/vault.hcl

# Copy script to generate PostgreSQL credentials
COPY ./scripts/generate-postgres-credentials.sh /usr/local/bin/generate-postgres-credentials.sh
RUN chmod +x /usr/local/bin/generate-postgres-credentials.sh
RUN /usr/local/bin/generate-postgres-credentials.sh

# Copy script to wait for vault
COPY ./scripts/wait-for-vault.sh /usr/local/bin/wait-for-vault.sh
RUN chmod +x /usr/local/bin/wait-for-vault.sh

# Start Vault server and run script to generate and upload PostgreSQL credentials
CMD vault server -dev -config=/vault/config/vault.hcl && \
    /usr/local/bin/wait-for-vault.sh && \
    vault kv put secret/postgres-credentials username="Test" password="$POSTGRES_PASSWORD"
