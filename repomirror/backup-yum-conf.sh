#!/bin/bash

# Where the "Live" backup mirror stays
source /etc/sysconfig/repomirror
LATEST="$YumConfBackupDir/latest"
INCREMENTAL_DIR="$YumConfBackupDir/$(date +%F_%H%M%S)"
mkdir -p $LATEST 2>/dev/null
mkdir -p $INCREMENTAL_DIR 

# List of targets
TARGETS=(
    "/etc/yum.repos.d"
    "/etc/dnf/dnf.conf"
)

echo "Backing up to $LATEST..."
mkdir -p "$LATEST"

# -a: Archive
# -R: Relative paths (preserves /etc/...)
# --backup: Move existing files to backup-dir if they change
# --backup-dir: Where to put the "clobbered" versions
rsync -aR --backup --backup-dir="$INCREMENTAL_DIR" "${TARGETS[@]}" "$LATEST/"

echo "Sync complete."
