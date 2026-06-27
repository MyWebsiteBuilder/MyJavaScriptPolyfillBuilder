#!/usr/bin/env bash

set -euo pipefail

build() {

  local src="$1"
  local dst="$2"

  if [[ -f "$src" ]]; then

    npx swc "$src" -o "${dst/%.js/.optimized.js}" -q

    if [[ "${MODE:-development}" == production ]]; then

      npx rolldown "${dst/%.js/.optimized.js}" -o "$dst" -f iife -m

    else

      npx rolldown "${dst/%.js/.optimized.js}" -o "$dst" -f iife

    fi

    rm "${dst/%.js/.optimized.js}"

  fi

}

