#!/bin/bash

set -e -o pipefail

increment_version() {
  local version=$1
  local releaseType=$2

  local delimiter=.
  local array=($(echo "${version}" | tr $delimiter '\n'))

  array[$releaseType]=$((array[$releaseType]+1))
  if [ $releaseType -lt 2 ]; then array[2]=0; fi
  if [ $releaseType -lt 1 ]; then array[1]=0; fi

  echo $(local IFS=$delimiter ; echo "${array[*]}")
}

cd "${GITHUB_WORKSPACE}" || exit

git config --global --add safe.directory "${GITHUB_WORKSPACE}"
git config user.name "github-actions"
git config user.email "github-actions@users.noreply.github.com"
git fetch

COMMIT_MESSAGE="${INPUT_COMMIT_MESSAGE}"
git checkout version/master
masterVersion=$(cat version)

releaseVersion="${masterVersion: : -2}"
echo "${releaseVersion}"
releaseBranch="release/v${releaseVersion}"
releaseVersionBranch="version/v${releaseVersion}"

git checkout -b "${releaseBranch}"
git push --set-upstream origin "${releaseBranch}"

git checkout -b "${releaseVersionBranch}"
git push --set-upstream origin "${releaseVersionBranch}"

git checkout version/master

major=0
minor=1
patch=2

releaseType="${patch}"
if [[ "${COMMIT_MESSAGE}" =~ "minor" ]]; then
  releaseType="${minor}"
else
  releaseType="${major}"
fi

newMasterVersion=$(increment_version ${masterVersion} "${releaseType}")
echo "${newMasterVersion}" > version
git add version
git commit -m "Bump version to ${newMasterVersion}"
git push

git checkout master

echo "version-master=${newMasterVersion}" >> $GITHUB_OUTPUT
