#!/bin/bash
set -e
mkdir -p /data

if [ ! -f /data/.token_created ]; then
  mayhem up --rail fiat --yes --gateway-bind 0.0.0.0:11435 --gateway-require-auth &
  MAYHEM_PID=$!
  sleep 20
  echo "===== COPIAȚI TOKENUL DE MAI JOS ACUM ====="
  mayhem tokens create --name recepai-backend
  echo "================================================"
  touch /data/.token_created
  wait $MAYHEM_PID
else
  exec mayhem up --rail fiat --yes --gateway-bind 0.0.0.0:11435 --gateway-require-auth
fi
