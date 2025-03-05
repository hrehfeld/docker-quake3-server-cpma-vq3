#!/bin/sh
set -euxo pipefail

/opt/quake3/quake3e.ded.x86_64 \
    +set dedicated 2 \
    +set com_hunkmegs 128 \
    +set sv_master1 master.quake3arena.com:27950 \
    +set sv_master2 master.ioquake3.org:27950 \
    +set sv_master3 master.maverickservers.com:27950 \
    +set sv_master4 master.quakeservers.net:27950 \
    +set sv_master5 master.qtracker.com:27900 \
    +set fs_game cpma \
    +set vm_game 2 \
    +set net_port "${LISTEN_PORT:-27960}" \
    +sets .admin.        "${SERVER_ADMIN}" \
    +sets .location      "${SERVER_LOCATION}" \
    +set sv_hostname     "${SV_HOSTNAME}" \
    +set ref_password    "${REF_PASSWORD:-none}" \
    +set rconPassword    "${RCONPASSSWORD:-}" \
    +set sv_privatePassword    "${SV_PRIVATEPASSWORD:-}" \
    +set ttycon 0 \
    +set developer 0 \
    +set sv_allowDownload 1 \
    +sets sv_dlURL "${DOWNLOAD_URL}" \
    +set server_motdfile "${MOTD_FILE}" \
    +exec server.cfg &

tail -f /proc/1/fd/1
