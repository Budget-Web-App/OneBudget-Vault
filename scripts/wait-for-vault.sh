#!/bin/bash

# Wait for Vault server to be ready
while ! vault status > /dev/null 2>&1; do
  sleep 1
done
