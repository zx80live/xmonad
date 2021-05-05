TODO describe dependencies:

- xmobar
- zsh
- OhMyZsh
- stalonetray
- feh
- uxrvt
- pidgin
- skypeforlinux
- cabal
- google-chrome
- pactl
- rofi
- amixer
- speaker-test

##### Install xmonad on Ubuntu 18 (stack)
```bash
mkdir -p ~/.local/bin

sudo apt install git curl vim rofi
sudo apt install libx11-dev libxrandr-dev libxinerama-dev libxss-dev pkg-config libxft-dev

curl -sSL https://get.haskellstack.org/ | sh
stack setup

mkdir ~/.xmonad
cd ~/.xmonad
git clone "https://github.com/xmonad/xmonad" xmonad-git
git clone "https://github.com/xmonad/xmonad-contrib" xmonad-contrib-git
git clone "https://github.com/jaor/xmobar" xmobar-git

stack init
stack install

sudo vim /usr/share/xsessions/xmonad.desktop
```

```
[Desktop Entry]
Encoding=UTF-8
Type=Application
Name=Xmonad
Comment=Xmonad
Exec=xmonad
Icon=xmonad
Terminal=false
StartupNotify=false
Categories=Application;
```

##### Used links
[setup xmonad from sources](https://brianbuccola.com/how-to-install-xmonad-and-xmobar-via-stack/)
