#!/bin/sh
set -e

DATA_DIR="/meshcenter"
cd "$DATA_DIR"
mkdir -p meshcentral-data meshcentral-files meshcentral-backups meshcentral-recordings

exec node /app/node_modules/meshcentral --wanonly --tlsoffload
