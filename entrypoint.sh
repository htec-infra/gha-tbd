#!/bin/bash

echo ""
echo "########"
echo "# GitHub Action for Trunk-based development pipelines"
echo "######"
echo ""

OP="${1}"
PARAMS="${2}"

if [[ "${OP}" == "help" ]]; then
  echo ""
  echo "Supported operations:"
  echo "  - get_version: "
  echo "  - prepare_release: "
  echo ""
fi

if [[ "${OP}" == "get_version" ]]; then
  echo ">>> Extracting repo data"
  /bin/bash /app/repo_data.sh

  exit 0
fi

if [[ "${OP}" == "prepare_release" ]]; then
  echo ">>> Preparing Release branch"
  /bin/bash /app/prepare_app_release.sh ${PARAMS}

  exit 0
fi

if [[ "${OP}" == "docker_ops" ]]; then
    echo ">>> Running Docker operation with following parameters # '${2}'"
    /bin/bash /app/docker_ops.sh ${PARAMS}
fi