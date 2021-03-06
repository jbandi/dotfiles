if ! is-macos -o ! is-executable ruby -o ! is-executable curl -o ! is-executable git; then
  echo "Skipped: Homebrew (missing: ruby, curl and/or git)"
  return
fi

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew tap Goles/battery
brew update
brew upgrade

# Install packages

apps=(
  bash-completion2
  bats
  battery
  cloc
  coreutils
  diff-so-fancy
  dockutil
  ffmpeg
  fasd
  gifsicle
  git
  git-extras
  gnu-sed --with-default-names
  grep --with-default-names
  heroku/brew/heroku
  hub
  httpie
  imagemagick
  jq
# lynx
  mackup
  nano
  pandoc
  peco
  psgrep
  python
  shellcheck
  ssh-copy-id
  tree
  wget
  wifi-password
  youtube-dl
  zsh
  zsh-completions
  zsh-syntax-highlighting
)

brew install "${apps[@]}"

export DOTFILES_BREW_PREFIX_COREUTILS=`brew --prefix coreutils`
set-config "DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_CACHE"

ln -sfv "$DOTFILES_DIR/etc/mackup/.mackup.cfg" ~
ln -sfv "$DOTFILES_DIR/etc/mackup/.mackup" ~


#change default shell
sudo echo /usr/local/bin/zsh >> /etc/shells
chsh -s /usr/local/bin/zsh
