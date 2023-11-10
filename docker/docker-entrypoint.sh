#!/bin/bash

titan_log() {
    local type="$1"; shift
    printf '%s [%s] [Entrypoint]: %s\n' "$(date --rfc-3339=seconds)" "$type" "$*"
}

append_command() {
    local var_name="$1"
    local var_value="$2"
    local is_required="$3"
    local error_message="$4"

    if [[ -n "${var_value}" ]]; then
        COMMAND+=("-${var_name}" "${var_value}")
        titan_log INFO "Setting ${var_name} to: ${var_value}"
    elif [[ "${is_required}" == "true" ]]; then
        titan_log ERROR "${error_message}"
        exit 1
    else
        titan_log INFO "${error_message}"
    fi
}

COMMAND=("/usr/local/bin/titan" "-configPath" "/config")

titan_log INFO "Starting Titan"

append_command "ethAddr" "${ethAddr}" "true" "Eth Address not supplied"
append_command "nickname" "${nickname}" "true" "Nickname was not supplied"
append_command "maxSessions" "${maxSessions}" "false" "No maxSession defined, will run benchmark"
append_command "nvidia" "${nvidia}" "false" "No NVIDIA card specified, using ALL"

"${COMMAND[@]}"
