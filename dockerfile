FROM hashicorp/vault:latest

# Copy Vault configuration file
COPY vault.hcl /vault/config/vault.hcl

# Copy script to generate PostgreSQL credentials
COPY ./scripts/generate-postgres-credentials.sh /usr/local/bin/generate-postgres-credentials.sh
RUN chmod +x /usr/local/bin/generate-postgres-credentials.sh

# Generate PostgreSQL credentials and upload them to Vault
RUN /usr/local/bin/generate-postgres-credentials.sh
RUN vault kv put secret/postgres-credentials username="$POSTGRES_USER" password="$POSTGRES_PASSWORD"

# Start Vault server
CMD ["vault", "server", "-config", "/vault/config/vault.hcl"]
