#!/bin/bash

# Check if Maven is installed and is at least version 3.9
if ! command -v mvn &> /dev/null; then
    echo "Error: Maven is not installed. Please install Maven before running this script."
    exit 1
fi

maven_version=$(mvn -v | grep "Apache Maven" | sed -n 's/Apache Maven \([0-9.]*\)/\1/p')
required_maven_version="3.9.0"

if [ "$(printf '%s\n' "$required_maven_version" "$maven_version" | sort -V | head -n1)" != "$required_maven_version" ]; then
    echo "Error: Maven version $required_maven_version or higher is required. Current version: $maven_version"
    exit 1
fi

# Check if Java is installed and is at least version 17 using JAVA_HOME
if [ -z "$JAVA_HOME" ]; then
    echo "Error: JAVA_HOME is not set. Please set JAVA_HOME before running this script."
    exit 1
fi

java_version="$("$JAVA_HOME"/bin/java -version 2>&1 | grep -i version | sed -n 's/.*version "\(.*\)\.\(.*\)\..*"/\1\2/p')"
required_java_version="17"

if [ "$java_version" -lt "$required_java_version" ]; then
    echo "Error: Java version $required_java_version or higher is required. Current version: $java_version"
    exit 1
fi

resources_path="$(cd "$(dirname "$0")" && pwd)"
cd "$resources_path" || exit
curl -o java-debug-main.zip https://codeload.github.com/microsoft/java-debug/zip/refs/heads/main
unzip java-debug-main.zip
rm -f java-debug-main.zip
cd java-debug-main || exit
mvn clean install -DskipTests
cd ..
mv $(find $resources_path -wholename "*plugin/*plugin*.jar") $resources_path/java-debug.jar
rm -fR java-debug-main

echo "Java Debug plugin installed successfully."
