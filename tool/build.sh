#!/usr/bin/env bash

set -e

which fvm > /dev/null || { echo "fvm not installed"; exit 1; }

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
TEMP_DIR=$(mktemp -d)
REPO_ROOT_DIR=${SCRIPT_DIR}/..
FLUTTER_BUILD_DIR=${REPO_ROOT_DIR}/build/web

cd ${REPO_ROOT_DIR}
flutter build web --base-href /registration-desk/

cd ${SCRIPT_DIR}
if [[ -d src ]]; then
  rm -rf src/
fi
mkdir -p webjar/src/main/resources/META-INF/resources/registration-desk
cp -r ${FLUTTER_BUILD_DIR}/* webjar/src/main/resources/META-INF/resources/registration-desk

cp -r ${SCRIPT_DIR}/webjar/* ${TEMP_DIR}

cd ${TEMP_DIR}
git init
git add .
git commit -m "Add code for snapshot release"

pwd
git remote add origin git@github.com:ksch-workflows/registration-desk.git

VERSION="0.0.10"

git tag $VERSION
git push origin $VERSION
