#!/bin/bash

echo ""
echo "########"
echo "# GitHub Action for Trunk-based development pipelines"
echo "######"
echo ""

OP="${1}"

if [[ "${OP}" == "get_version" ]]; then
  echo "Extracting repo data"
  /bin/bash /app/repo_data.sh

  exit 0
fi

