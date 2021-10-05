build() {
    DOCKER_BUILDKIT=1 docker build --build-arg VERSION="${APP_VERSION}" --build-arg REVISION="${APP_REVISION}" \
        -t "${DOCKER_IMG_TAG}" -f infra/Dockerfile .
}

publish() {
    docker push "${DOCKER_IMG_TAG}"
}

APP_CONFIG_FILE="${GITHUB_WORKSPACE}/infra/app.conf"
if [[ -f "${APP_CONFIG_FILE}" ]]; then
    echo "Application Config detected! Loading parameters..."
    source "${APP_CONFIG_FILE}"
fi

DOCKER_IMG_TAG="${DOCKER_REPO}:${APP_VERSION}"
"${1}"
