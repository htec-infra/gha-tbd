#!/bin/bash

echo ""
echo "##########"
echo "# REPO DATA test"
echo "######"
echo ""

test_alpha_version() {
	result=$(docker run --rm \
	  -e GITHUB_REF="main" \
	  -e GITHUB_SHA="1234567" \
	  -e GITHUB_REPOSITORY="repo/test" \
	  -e GITHUB_RUN_NUMBER=100 \
	  -e GITHUB_WORKSPACE="/repo" \
	  -v "${WORKSPACE}":/repo \
	  gha-tbd get_version)

	  echo "$result"

    # Assert values
	  if [ "$(echo "$result" | grep "App Version: alpha-1234567" -c )" -eq 1 ]; then echo "OK"; else echo "FAILED"; fi
}

test_beta_version() {
	result=$(docker run --rm \
	  -e GITHUB_REF="refs/pull/17/merge" \
	  -e GITHUB_HEAD_REF="release/1.3.44" \
	  -e GITHUB_SHA="1234567" \
	  -e GITHUB_REPOSITORY="repo/test" \
	  -e GITHUB_RUN_NUMBER=100 \
	  -e GITHUB_WORKSPACE="/repo" \
	  -v "${WORKSPACE}":/repo \
	  gha-tbd get_version)

	  echo "$result"

    # Assert values
	  if [ "$(echo "$result" | grep "App Version: 1.3.44-rc+100" -c )" -eq 1 ]; then echo "OK"; else echo "FAILED"; fi
}


test_prod_version() {
	result=$(docker run --rm \
	  -e GITHUB_REF="main" \
	  -e GITHUB_HEAD_REF="release/1.3.44" \
	  -e GITHUB_SHA="1234567" \
	  -e GITHUB_REPOSITORY="repo/test" \
	  -e GITHUB_RUN_NUMBER=100 \
	  -e GITHUB_WORKSPACE="/repo" \
	  -v "${WORKSPACE}":/repo \
	  gha-tbd get_version)

	  echo "$result"

    # Assert values
	  if [ "$(echo "$result" | grep "App Version: 1.3.44" -c )" -eq 1 ]; then echo "OK"; else echo "FAILED"; fi
}

docker build -t gha-tbd .


WORKSPACE="$(dirname "$(readlink -f "$0")")"

test_alpha_version

test_beta_version

test_prod_version
