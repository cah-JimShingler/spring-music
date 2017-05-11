#!/bin/sh

set -e # fail fast
set -x # print commands

export TERM=${TERM:-dumb}

echo "Build and Publish to Maven Repo"
pwd
cd source-code
pwd
# ./gradlew assemble
# ./gradlew writePom
gradle -PmyIP=${myIP} assemble
gradle -PmyIP=${myIP} writePom
#publish

echo "Move artifacts to output area"
cp build/libs/spring-music.war ../build

# ./gradlew publish -PrepoUrl=${MAVEN_REPO}
# gradle publish -PrepoUrl=${MAVEN_REPO}

echo "Build and Publish -- Done"
