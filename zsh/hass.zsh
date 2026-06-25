hass-cli() {
    [[ -z "$HASS_SERVER" ]] && export HASS_SERVER="$(op read 'op://private/Home Assistant/api-uri')"
    [[ -z "$HASS_TOKEN" ]] && export HASS_TOKEN="$(op read 'op://private/Home Assistant/hass-cli')"

    command hass-cli "$@"
}
