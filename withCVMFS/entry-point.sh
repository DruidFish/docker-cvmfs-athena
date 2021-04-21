#!/bin/bash
set -e

cvmfs_config setup
cvmfs_config probe

exec "$@"

