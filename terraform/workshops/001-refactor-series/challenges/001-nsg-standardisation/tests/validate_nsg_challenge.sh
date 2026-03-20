#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TF_FILES=("${ROOT_DIR}"/*.tf)

if [[ ! -f "${TF_FILES[0]}" ]]; then
  echo "FAIL: No Terraform files found under ${ROOT_DIR}"
  exit 1
fi

search() {
  local pattern="$1"

  if command -v rg >/dev/null 2>&1; then
    rg -q --glob '*.tf' "${pattern}" "${ROOT_DIR}"
  else
    grep -Eqs "${pattern}" "${TF_FILES[@]}"
  fi
}

pass_count=0
fail() {
  echo "FAIL: $1"
  exit 1
}

pass() {
  echo "PASS: $1"
  pass_count=$((pass_count + 1))
}

if search "^locals\\s*\\{"; then
  pass "locals block exists"
else
  fail "Expected a locals block in challenge Terraform files"
fi

if search "nsg_rules\\s*=\\s*\\{"; then
  pass "local.nsg_rules exists"
else
  fail "Expected local.nsg_rules map in locals block"
fi

has_dynamic=false
has_separate_resource=false

if search "dynamic\\s+\"security_rule\""; then
  has_dynamic=true
fi

if search "resource\\s+\"azurerm_network_security_rule\""; then
  has_separate_resource=true
fi

if [[ "${has_dynamic}" == "true" || "${has_separate_resource}" == "true" ]]; then
  pass "rule generation pattern found (dynamic block or separate resource)"
else
  fail "Expected either dynamic \"security_rule\" or azurerm_network_security_rule resource"
fi

if search "for_each\\s*="; then
  pass "for_each loop found"
else
  fail "Expected for_each loop for rule generation"
fi

if search "AllowEverythingElse"; then
  fail "Found legacy hard-coded AllowEverythingElse rule"
else
  pass "legacy AllowEverythingElse rule removed"
fi

echo ""
echo "All checks passed (${pass_count} checks)."
