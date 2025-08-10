#!/bin/bash

# Agent OS Extended - Update All Files
# Updates both standards and instructions files in the current project

curl -sSL https://raw.githubusercontent.com/michsindlinger/agent-os-extended/main/setup.sh | bash -s -- --overwrite-instructions --overwrite-standards