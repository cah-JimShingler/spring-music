#!/bin/bash

# Assumptions:
# 1) Concourse Server has been setup
# 2) Fly client has been installed
# 3) branch exist in remote git: e.g: git push -u origin <branch_name>
#
echo "Helpful commands:"
echo "  fly -t lite login -c http://192.168.100.4:8080"
echo "  fly -t lite intercept -j spring-music_master_CI/unit-test -b 33"

branch=$(git symbolic-ref --short HEAD)

target=$1
base=`basename "$PWD"`

# Build Maven Repo URL for use by build publish
myIP=`ifconfig en0 | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'`
MAVEN_REPO="http://${myIP}:8081/repository/maven-releases/"
SONAR="http://${myIP}:9000"
echo ""
echo "Maven Repo: ${MAVEN_REPO}"
echo "Sonar:      ${SONAR}"
echo ""
echo "Setup ${base}_${branch}_CI on target: ${target}"
echo "========================================"
fly -t ${target} set-pipeline --pipeline ${base}_${branch}_CI -c ci/pipeline.yml --var "MAVEN_REPO=${MAVEN_REPO}" --var "SONAR=${SONAR}" -l credentials.yml

# echo ""
# echo "Setup ${base}_${branch}_Gated on target: ${target}"
# echo "========================================"
# fly -t ${target} set-pipeline --pipeline ${base}_${branch}_Gated -c ci/pipeline-gated.yml -l credentials.yml
