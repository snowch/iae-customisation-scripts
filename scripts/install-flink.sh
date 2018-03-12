#!/bin/bash

# INTRODUCTION: Install Flink.  
# PARAMETERS: None - this script does not require any parameters
# WARNING: Flink does not seem to work well with S3: https://issues.apache.org/jira/browse/FLINK-8543

# abort on error
set -e

FLINK_HOME=$(pwd)/flink-1.4.0

# Download Flink - IAE as of 2018-01-29 is based on hadoop 2.7
wget -c -O flink-1.4.0-hadoop27-scala_2.11.tgz \
  "http://www.apache.org/dyn/mirrors/mirrors.cgi?action=download&filename=flink/flink-1.4.0/flink-1.4.0-bin-hadoop27-scala_2.11.tgz"

# Backup old flink installations
[[ -d flink-1.4.0 ]] && mv flink-1.4.0 flink-1.4.0-backup-$(date +%Y%m%d%H%M%S)

# Extract clean installation
tar xf flink-1.4.0-hadoop27-scala_2.11.tgz
