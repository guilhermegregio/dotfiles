# dotfiles

Configs de `~/.config` gerenciadas com [GNU stow](https://www.gnu.org/software/stow/) —
editáveis sem rebuild, nas três máquinas (NixOS e macOS).

A outra metade do setup é o [gregioos](https://github.com/guilhermegregio/gregioos):
**ele instala o sistema e os binários; este repo é dono dos arquivos de
configuração.** A fronteira, por critério:

| depende de host, plataforma ou nix store | config pura, editada com frequência |
|---|---|
| fica no gregioos (`fr`/`fu`) | fica aqui (editar + commit) |

## Uso

```bash
git clone https://github.com/guilhermegregio/dotfiles.git ~/code/dotfiles
cd ~/code/dotfiles
./install.sh          # stow --restow dos pacotes desta plataforma
```

Cada diretório de topo é um pacote stow espelhando o `$HOME`:
`zellij/.config/zellij/config.kdl` vira `~/.config/zellij/config.kdl`.

Editar é editar — o symlink aponta para o working tree. `git diff` mostra o que
mudou; `git revert` é o rollback.

## Ordem numa máquina nova

1. gregioos aplicado (`fr`) — instala os binários e o `stow`
2. `./install.sh`
3. terminal novo

O home-manager do gregioos **não** gerencia os arquivos daqui — um arquivo tem
um dono só. Se um `stow` acusar conflito, é porque o gregioos dessa máquina
ainda gera aquele arquivo: atualize-o primeiro.

## Histórico

As branches `master` e `nixpkgs` guardam a encarnação anterior deste repo (um
flake nix-darwin standalone), absorvida pelo gregioos em ago/2026.

Inspiração: [omerxx/dotfiles](https://github.com/omerxx/dotfiles).
