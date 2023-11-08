#!/bin/bash

titan_log() {
	local type="$1"; shift
	printf '%s [%s] [Entrypoint]: %s\n' "$(date --rfc-3339=seconds)" "$type" "$*"
}

COMMAND="/usr/local/bin/titan -configPath /config"
if [[ -n ${ethAddr} ]]; then
    COMMAND="${COMMAND} -ethAddr ${ethAddr}"
    titan_log INFO "Running with Address: ${ethAddr}"
else
    titan_log ERROR "Eth Address not supplies"
    exit 1
fi

if [[ -n ${nickname} ]]; then
    COMMAND="${COMMAND} -nickname ${nickname}"
    titan_log INFO "Setting nickname to: ${nickname}"
else
    titan_log ERROR "Nickname was not supplied"
    exit 1
fi

if [[ -n ${maxSessions} ]]; then
    COMMAND="${COMMAND} -maxSessions ${maxSessions}"
    titan_log INFO "Setting maxSessions to: ${maxSessions}"
else
    titan_log INFO "No maxSession definied, will run benchmark"
fi

if [[ -n ${nvidia} ]]; then
    COMMAND="${COMMAND} -nvidia ${nvidia}"
    titan_log INFO "Using NVIDIA Card: ${nvidia}"
else
    titan_log INFO "No NVIDIA card specified, using ALL"
fi
eval ${COMMAND}
