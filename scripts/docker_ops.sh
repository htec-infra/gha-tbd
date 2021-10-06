#!/bin/bash

build() {
    DOCKER_FILE=${1:-infra/Dockerfile}
    DOCKER_BUILDKIT=1 docker build --progress=plain \
        --build-arg VERSION="${APP_VERSION}" --build-arg REVISION="${APP_REVISION}" \
        -t "${DOCKER_IMG_TAG}" \
        -f "$DOCKER_FILE" .
}

publish() {
    docker push "${DOCKER_IMG_TAG}"
}

#######
#   MAIN
####

APP_CONFIG_FILE="${GITHUB_WORKSPACE}/infra/app.conf"
if [[ -f "${APP_CONFIG_FILE}" ]]; then
    echo "Application Config detected! Loading parameters..."
    # shellcheck source=${GITHUB_WORKSPACE}/infra/app.conf
    source "${APP_CONFIG_FILE}"
fi

if [[ -z  "${DOCKER_REPO}" ]]; then
  echo "Docker root repository is not defined. Aborting docker operations."
  exit 1
fi

DOCKER_IMG_TAG="${DOCKER_REPO}:${APP_VERSION}"

echo ""
echo ">>> ${1} in progress..."
echo ">>>>> image: ${DOCKER_IMG_TAG}"
echo ""

"${1}" "${2}"

echo ""
echo ">>> ${1} finished."
echo ""