#!/bin/bash
# Write Hermes .env from Docker env vars
mkdir -p /opt/data/.hermes
mkdir -p /opt/data/whatsapp
mkdir -p /opt/data/platforms/whatsapp

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

# Fix permissions for hermes user (UID 10000)
chown -R 10000:10000 /opt/data

# If PAIRING_MODE=true, just keep the container alive without starting gateway
# so you can pair WhatsApp via the terminal
if [ "${PAIRING_MODE}" = "true" ]; then
    echo "=== PAIRING MODE ==="
    echo "Container staying alive for WhatsApp pairing."
    echo "Run in terminal: source /opt/hermes/.venv/bin/activate && hermes whatsapp"
    echo "After pairing, set PAIRING_MODE=false and redeploy."
    exec tail -f /dev/null
fi

# Hand off to the original entrypoint
exec /opt/hermes/docker/entrypoint.sh gateway run
