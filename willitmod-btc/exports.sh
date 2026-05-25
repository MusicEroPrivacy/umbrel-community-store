#!/bin/bash

# =============================================
# Axe-Parasite (WillItMod fork) - exports.sh
# =============================================

# App Info
export APP_ID="axe-parasite"
export APP_NAME="Axe-Parasite"
export APP_VERSION="0.1.0"

# Ports
export APP_PORT=3000                    # Web UI
export STRATUM_PORT=7890                # Miners connect here

# Internal service names
export APP_HOST="axe-parasite-app"

# Bitcoin Node
export BITCOIN_RPC_USER="btc"
export BITCOIN_RPC_PORT=28332
export BITCOIN_P2P_PORT=28333
export BITCOIN_ZMQ_HASHBLOCK_PORT=28335

# Pool / Proxy Settings
export UPSTREAM_POOL="stratum+tcp://parasite.wtf:42069"
export PAYOUT_ADDRESS="${PAYOUT_ADDRESS:-CHANGEME_parasite_username_or_lnaddress}"

# Dashboard / UI
export NODE_TYPE="Libre Node"
export APP_CHANNEL="Parasite Pool"

# Useful paths
export DATA_DIR="${APP_DATA_DIR}/data"
export NODE_DIR="${DATA_DIR}/node"
export POOL_DIR="${DATA_DIR}/pool"

# =============================================
# Helper functions (Umbrel standard)
# =============================================

# Get app data directory
app_data_dir() {
    echo "${APP_DATA_DIR}"
}

# Get app password (for RPC etc)
app_password() {
    echo "${APP_PASSWORD}"
}

# Restart the app
restart_app() {
    echo "Restarting Axe-Parasite..."
    docker compose -f "${APP_DATA_DIR}/docker-compose.yml" restart
}

# Show status
status() {
    echo "=== Axe-Parasite Status ==="
    echo "UI: http://$(hostname -I | awk '{print $1}'):${APP_PORT}"
    echo "Stratum: stratum+tcp://$(hostname -I | awk '{print $1}'):${STRATUM_PORT}"
    echo "Upstream Pool: ${UPSTREAM_POOL}"
    echo "Node Type: ${NODE_TYPE}"
}

# Export everything
export -f app_data_dir app_password restart_app status
