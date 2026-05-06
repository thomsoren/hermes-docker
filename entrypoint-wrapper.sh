#!/bin/bash
# Write Hermes .env from Docker env vars
mkdir -p /opt/data/.hermes
cat > /opt/data/.hermes/.env << ENVFILE
GEMINI_API_KEY=${GEMINI_API_KEY}
WHATSAPP_ENABLED=${WHATSAPP_ENABLED:-false}
WHATSAPP_MODE=${WHATSAPP_MODE:-bot}
WHATSAPP_ALLOW_ALL_USERS=${WHATSAPP_ALLOW_ALL_USERS:-false}
GATEWAY_ALLOW_ALL_USERS=${GATEWAY_ALLOW_ALL_USERS:-false}
ENVFILE

# Write config.yaml with model
cat > /opt/data/.hermes/config.yaml << YAMLFILE
model: ${HERMES_MODEL:-gemini/gemini-3.1-flash-lite-preview}
YAMLFILE

# Hand off to the original entrypoint
exec /opt/hermes/docker/entrypoint.sh gateway run
