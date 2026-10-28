#!/usr/bin/env bash
set -euo pipefail
while IFS= read -r f; do
  bash -n "$f"
  expected=${f##*/}; expected=${expected#feature-}; expected=${expected%.sh}
  [ "$(bash "$f")" = "$expected" ] || { echo "wrong feature output: $f" >&2; exit 1; }
done < <(find features protected -name 'feature-*.sh' -type f | sort)
echo 'all present feature outputs match their names'
