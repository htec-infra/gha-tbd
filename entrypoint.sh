#!/bin/bash
OP="${1}"

if [[  "${OP}" == "get_version" ]]; then
  echo "Extracting repo data"
  /bin/bash /app/repo_data.sh
fi
