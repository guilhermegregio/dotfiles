#!/usr/bin/env bash
# Aplica os pacotes stow desta máquina.
#
# Pré-requisito: o gregioos já aplicado (`fr`) — é ele quem instala o `stow` e
# quem NÃO pode mais estar gerenciando os arquivos daqui (um dono por arquivo).
# Ordem certa numa máquina nova: fr -> ./install.sh -> terminal novo.
set -euo pipefail
cd "$(dirname "$0")"

COMMON=(starship ghostty helix btop)
MACOS=()          # aerospace herdr — entram na fase 2
LINUX=()

pkgs=("${COMMON[@]}")
case "$(uname -s)" in
  Darwin) pkgs+=("${MACOS[@]}") ;;
  Linux)  pkgs+=("${LINUX[@]}") ;;
esac

echo "stow: ${pkgs[*]}"
stow "$@" "${pkgs[@]}"
echo "ok. links apontando para $(pwd)"
