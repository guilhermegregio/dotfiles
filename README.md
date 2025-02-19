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