#!/bin/bash

# exit on non-zero exit from go test/vet
set -e

TEST_TIMEOUT=15m

# change path into root directory
cd $(dirname $(dirname $(readlink -f $0)))

# import common functions
. ./bin/_common.sh

PKGS="$(go list ./...)"

# Support passing custom flags (-json, etc.)
OPTS="$@"
if [[ -z "$OPTS" ]]; then
	OPTS="-race -count=1 -failfast -v"
fi



for pkg in $(listPackages); do
    trimmed_pkg=${pkg/github.com\/TykTechnologies\//}
    pkg_name=${trimmed_pkg//\//.}
    coveragefile=$(echo "$pkg_name")


    set -x
    go test \
	-failfast \
	-timeout ${TEST_TIMEOUT:-"20m"} \
    -cover \
	-coverprofile=${coveragefile}.cov \
	-v ${pkg}
    set +x

done