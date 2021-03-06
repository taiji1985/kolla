#!/bin/bash

# Bootstrap and exit if KOLLA_BOOTSTRAP variable is set. This catches all cases
# of the KOLLA_BOOTSTRAP variable being set, including empty.
if [[ "${!KOLLA_BOOTSTRAP[@]}" ]]; then
    if [[ "${CEILOMETER_DATABASE_TYPE}" == "gnocchi" ]]; then
        ceilometer-upgrade "${CEILOMETER_UPGRADE_PARAMS}"
    else
        echo "Unsupported database type: ${CEILOMETER_DATABASE_TYPE}"
        exit 1
    fi
    sudo chown -R ceilometer: /var/lib/ceilometer/
    exit 0
fi
