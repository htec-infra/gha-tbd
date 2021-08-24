#!/bin/sh
OP="${1}"

if [[  "${OP}" == "get_version" ]]; then
  echo "Extracting repo data"
  /bin/sh /app/repo_data.sh
fi
