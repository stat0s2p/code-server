#!/usr/bin/env bash
set -euo pipefail

# 1. Ensures VS Code is cloned.
# 2. Patches it.
# 3. Installs it.
main() {
  cd "$(dirname "$0")/../.."

  git submodule update --init

  # If the patch fails to apply, then it's likely already applied
  yarn vscode:patch &> /dev/null || true

  find . -type f -name yarn.lock -print0|xargs -0 sed -i 's+https://registry.yarnpkg.com+http://192.168.2.129:8081/repository/npmgroup+g'
  (
    cd lib/vscode
    # Install VS Code dependencies.
    yarn ${CI+--frozen-lockfile}
  )
}

main "$@"
