#!/bin/bash
OP="${1}"

if [[  "${OP}" == "get_version" ]]; then
  /bin/bash /app/repo_data.sh
fi
