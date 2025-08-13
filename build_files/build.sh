#!/usr/bin/env bash
set -euo pipefail

PACKAGES_DIR=/tmp/packages
REMOVE_LIST="$PACKAGES_DIR/remove.txt"
INSTALL_LIST="$PACKAGES_DIR/install.txt"

_filter() { grep -vE '^[[:space:]]*(#|$)'; }

if [[ -s "$REMOVE_LIST" ]]; then
  echo "==> Removing base packages via rpm-ostree override remove"
  mapfile -t RM < <(_filter < "$REMOVE_LIST")
  if [[ ${#RM[@]} -gt 0 ]]; then
    rpm-ostree override remove "${RM[@]}"
  fi
fi

if [[ -s "$INSTALL_LIST" ]]; then
  echo "==> Installing layered packages via rpm-ostree install"
  mapfile -t PKG < <(_filter < "$INSTALL_LIST")
  if [[ ${#PKG[@]} -gt 0 ]]; then
    rpm-ostree install "${PKG[@]}"
  fi
fi
