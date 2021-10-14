#!/bin/bash
set -e

login() {
  if [[ ${DOCKER_REPO} == *dkr.ecr* ]]; then
    local REPO_DOMAIN=null REGION=us-east-1
    REPO_DOMAIN="$(echo "$DOCKER_REPO" | cut -d "/" -f 1)"
    REGION="$(curl -s http://169.254.169.254/latest/meta-data/placement/region)"
    # Run docker login in pipe
    aws ecr get-login-password --region "${REGION}" | docker login --username AWS --password-stdin "${REPO_DOMAIN}"
  fi
}

#
# build "${dockerfile_path}"
#
build() {
  DOCKER_FILE=${1:-infra/Dockerfile}
  DOCKER_BUILDKIT=1 docker build --progress=plain \
    --build-arg VERSION="${APP_VERSION}" --build-arg REVISION="${APP_REVISION}" \
    -t "${DOCKER_IMG_TAG}" \
    -f "$DOCKER_FILE" .
}

#
# push <no-parameters>
#

push() {
  docker push "${DOCKER_IMG_TAG}"
}

#
# run_cmd ${cmd} ${cmd_param1}
#
run_cmd() {
  echo ""
  echo ">>> ${1} in progress..."
  echo ">>>>> image: ${DOCKER_IMG_TAG}"
  echo ""

  "${1}" "${2}"

  echo ""
  echo ">>> ${1} finished."
  echo ""
}

###################################################################
#               MAIN
###################################################################

# >>>>>>>  Initialization

APP_CONFIG_FILE="${GITHUB_WORKSPACE}/infra/app.conf"
if [[ -f "${APP_CONFIG_FILE}" ]]; then
  echo "Application Config detected! Loading parameters..."
  # shellcheck source=${GITHUB_WORKSPACE}/infra/app.conf
  source "${APP_CONFIG_FILE}"
fi

if [[ -z "${DOCKER_REPO}" ]]; then
  echo "Docker root repository is not defined. Aborting docker operations."
  exit 1
fi

DOCKER_IMG_TAG="${DOCKER_REPO}:${APP_VERSION}"

# >>>>>>>  Start

# as first, build docker image
run_cmd build "${1}"

# as second, try to login
if [[ "${3}" == "true" ]]; then
  run_cmd login
fi
# as third, publish the image if not specified otherwise
# Parameter ${2} is `push_image` { true | false }
if [[ "${2}" == "true" ]]; then
  run_cmd push
else
  echo "(push = ${2}) Docker push disabled by user, image will not pushed to the Registry"
fi

# >>>>>>>  End
