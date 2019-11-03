#!/bin/sh

. ./trace.sh
. ./callbacks_txid.sh

newblock() {
  trace "Entering newblock()..."

  local request=${1}
  local blockhash=$(echo "${request}" | cut -d ' ' -f2 | cut -d '/' -f3)

  do_callbacks_txid
  if [ "$(( $(od -An -N2 < /dev/urandom) % 5 ))" = "0" ]; then
    trace "[newBlock] Let's try to spend mixed coins!"
    wasabi_batchprivatetospender
  else
    trace "[newblock] We won't try to spend mixed coins now, relax."
  fi
}
