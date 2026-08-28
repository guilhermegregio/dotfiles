# dotfiles
Meus Dotfiles

```sh
curl -L https://raw.githubusercontent.com/guilhermegregio/dotfiles/master/install.sh | bash
```



Dotfiles
https://github.com/ignovak/dotfiles
https://github.com/captbaritone/dotfiles
https://github.com/gHashTag/dotfiles
https://github.com/paulirish/dotfiles
https://github.com/sapegin/dotfiles
https://github.com/exAspArk/dotfiles
https://github.com/maxpou/dotfiles
https://github.com/naustudio/dotfiles

https://medium.com/@crashybang/should-front-end-developers-learn-a-tool-like-vim-bb49a7627313
https://github.com/webpro/awesome-dotfiles


nix --experimental-features "nix-command flakes" build ".#darwinConfigurations.BRSAOMN045381.system"

## NetSkope config

https://jackrose.co.nz/til/reliable-nix-netskope-install/

```
NETSKOPE_DATA_DIR="/Library/Application Support/Netskope/STAgent/data/"

security find-certificate -a -p \
  /System/Library/Keychains/SystemRootCertificates.keychain \
  /Library/Keychains/System.keychain \
  >/tmp/nscacert_combined.pem

sudo cp /tmp/nscacert_combined.pem "$NETSKOPE_DATA_DIR"
```

add on /etc/nix/nix.conf

```
ssl-cert-file = /Library/Application Support/Netskope/STAgent/data/nscacert_combined.pem
```


## Atualizar sistema

```sh
sudo /run/current-system/sw/bin/nix run nix-darwin -- switch --flake ~/.nixpkgs
```

## Homebrew: erro "untrusted tap" no `darwin-rebuild switch`

Desde o **Homebrew 6.0.0** o `HOMEBREW_REQUIRE_TAP_TRUST` vem ligado por default, então
*formulae* de taps de terceiros passam a exigir trust explícito e o switch aborta:

```
Error: Refusing to load formula felixkratz/formulae/borders from untrusted tap felixkratz/formulae.
```

### Não resolva com `brew trust` manual

Com `homebrew.onActivation.cleanup = "zap"` (é o nosso caso), o nix-darwin roda
`brew bundle --zap --force-cleanup`. O Homebrew, em `bundle/subcommand/cleanup.rb`, chama
`Trust.replace!`, que **sobrescreve o trust store inteiro** com apenas o que o Brewfile declara.
Ou seja: qualquer `brew trust` manual é apagado no switch seguinte.

### Fix declarativo

Marcar o tap como confiável — o nix-darwin emite `tap "...", trusted: true` no Brewfile, e o
`brew bundle` aplica isso antes de carregar as entradas:

```nix
taps = [{
  name = "Algum/homebrew-tap";
  trusted = true;
}];
```

`brews`/`casks` também têm `trusted` (default `true`), mas **só surte efeito com nome totalmente
qualificado** (`user/repo/nome`). Por isso `cask "nikitabobko/tap/aerospace"` funciona sozinho,
enquanto um `brew "borders"` (nome curto) precisava do trust vindo do tap.

### Onde fica o estado

`~/.homebrew/trust.json` (ou `$XDG_CONFIG_HOME/homebrew/trust.json` se setado), com as chaves
`trustedtaps` / `trustedformulae` / `trustedcasks` / `trustedcommands`.
Inspecionar: `brew trust --json=v1`. Opt-out global (deprecado): `HOMEBREW_NO_REQUIRE_TAP_TRUST=1`.

### Armadilha: `system.activationScripts` com nome arbitrário não executa

No nix-darwin, `modules/system/activation-scripts.nix` monta o script final concatenando uma
**lista fixa de nomes** — não itera os attrs. Uma chave nova (ex. `activationScripts.brewTrust`)
type-checka, avalia e **nunca roda**, sem warning nenhum. Hooks realmente utilizáveis:
`preActivation`, `extraActivation`, `postActivation`. O fragmento do homebrew roda entre
`mas` e `postActivation`.

### Nota histórica

O `borders` era instalado via `FelixKratz/homebrew-formulae`. Foi migrado para
`services.jankyborders` (pacote `jankyborders` do nixpkgs), o que removeu o tap de terceiro e a
necessidade de trust. O `~/.config/borders/bordersrc` foi removido — os args agora vêm do
`launchd.user.agents.jankyborders`.

## Aplicar a config

`darwin-rebuild` não está no PATH do root, então:

```sh
sudo env PATH=$PATH darwin-rebuild switch --flake .
```
