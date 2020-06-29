#!/usr/bin/env bash
set -euo pipefail

main() {
  cd "$(dirname "$0")/../.."

  cd ./lib/vscode
  git apply ../../ci/dev/vscode.patch
  find . -type f -name yarn.lock -print0|xargs -0 sed -i 's+https://registry.yarnpkg.com+http://192.168.2.129:8081/repository/npmgroup+g'
  find . -type f -name yarn.lock -print0|xargs -0 sed -i 's+https://codeload.github.com+http://192.168.2.129:8081/repository/codeload-github+g'
  find . -type f \( -name extensions.ts -o -name extensions.js \) -path "./build/lib/*" -print0|xargs -0 sed -i 's+https://marketplace.visualstudio.com+http://192.168.2.129:8081/repository/marketplace-vs+g'
  sed 's+https://extensions.coder.com+http://192.168.2.129:8081/repository/extensions-coder+g' -i ./src/vs/server/node/marketplace.ts
}

main "$@"
