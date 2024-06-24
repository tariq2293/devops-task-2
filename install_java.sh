#!/bin/bash
#EXERCISE 2: Bash Script - Install Java
brew update
brew install openjdk
java_installed=$(java -version 2>&1)

java_version=$(echo "$java_installed" | grep -oE '\"([0-9]+\.[0-9]+)' | tr -d '"')

version_lt() {
    test "$(echo "$@" | tr " " "\n" | sort -V | head -n 1)" != "$1"
}

if [[ -z "$java_version" ]]; then
    echo "Java is not installed."
elif version_lt "$java_version" "11"; then
    echo "An older version of Java is installed: $java_version"
else
    echo "Java version 11 or higher is installed: $java_version"
    echo "Java installation was successful."
fi

