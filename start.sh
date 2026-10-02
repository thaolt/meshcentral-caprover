#!/bin/sh
set -e

DATA_DIR="/meshcenter"
mkdir -p "$DATA_DIR"
cd "$DATA_DIR"

exec node /app/node_modules/meshcentral --wanonly --tlsoffload
