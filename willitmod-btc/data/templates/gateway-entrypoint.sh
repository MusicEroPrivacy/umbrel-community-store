#!/bin/sh
set -eu

UPSTREAM_POOL_HOST="$(echo "$UPSTREAM_POOL" | cut -d':' -f1)"
UPSTREAM_POOL_PORT="$(echo "$UPSTREAM_POOL" | cut -d':' -f2)"

STATUS_DIR="${STATUS_DIR:-/data/gateway/status}"
mkdir -p "$STATUS_DIR"

echo "✅ Parasite Gateway starting"
echo "   Upstream: $UPSTREAM_POOL_HOST:$UPSTREAM_POOL_PORT"
echo "   Listening on :3333"

# Write a very simple status file for the UI to read
cat > "$STATUS_DIR/status.json" <<EOF
{
  "upstream": "$UPSTREAM_POOL_HOST:$UPSTREAM_POOL_PORT",
  "listening": "0.0.0.0:3333",
  "mode": "tcp-forward",
  "pool": "Parasite"
}
EOF

# Install socat for TCP forwarding
apk add --no-cache socat >/dev/null 2>&1

# Simple TCP proxy: miners → this container:3333 → parasite.wtf:42069
exec socat TCP-LISTEN:3333,fork,reuseaddr TCP:"$UPSTREAM_POOL_HOST":"$UPSTREAM_POOL_PORT"
