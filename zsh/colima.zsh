if colima version >/dev/null 2>&1; then
    export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"
fi
