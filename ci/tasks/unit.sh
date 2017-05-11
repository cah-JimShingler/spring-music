#!/bin/sh

set -e # fail fast
set -x # print commands
export TERM=${TERM:-dumb}

echo "Test and Analysis (SonarQube)"
whoami

cd source-code
echo "Configuring Git"
git status
git config --global core.mergeoptions --no-edit
git config --global user.email "CI@concourse.ci"
git config --global user.name "Concourse.CI"
# git remote -v

echo "Run Tests and Sonar: ${SONAR}"
# Run Test on unrebased branch
# ./gradlew -Dsonar.host.url=${SONAR} test sonarqube
gradle -Dsonar.host.url=${SONAR} -PmyID=${myIP} test sonarqube
# ./gradlew assemble

# cp build/libs/spring-music.war ../build

echo "Test and Analysis (SonarQube) -- Done"
