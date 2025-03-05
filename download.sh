#!/bin/sh
set -euxo pipefail

download_dir="./download/baseq3/"

mkdir -p "$download_dir"
cd "$download_dir"


url="https://ws.q3df.org/maps/downloads/"

curl_cmd="curl -C - -f"

env url="$url" sh -c 'for map in map-charonq2dm1v2 pro-nodm9 map_nodm9 nodm10 map_nodm13 hub3aeroq3 hub3aeroq3a hub3tourney1 ztn3tourney1  q3shw26 sin szq2dm1ish; do echo "-O \"${url}${map}.pk3\""; done' | xargs $curl_cmd
