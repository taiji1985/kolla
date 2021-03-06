#!/bin/bash
set -o errexit

# Bootstrap and exit if KOLLA_BOOTSTRAP variable is set. This catches all cases
# of the KOLLA_BOOTSTRAP variable being set, including empty.
if [[ "${!KOLLA_BOOTSTRAP[@]}" ]]; then
    cinder-manage db sync
    exit 0
fi

if [[ "${!KOLLA_OSM[@]}" ]]; then
    if [[ "${!MAX_NUMBER[@]}" ]]; then
        cinder-manage db online_data_migrations --max_count ${MAX_NUMBER}
    else
        cinder-manage db online_data_migrations
    fi
    exit 0
fi

. /usr/local/bin/kolla_httpd_setup
