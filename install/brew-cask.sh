if ! is-macos -o ! is-executable brew; then
  echo "Skipped: Homebrew-Cask"
  return
fi

brew tap caskroom/cask
brew tap caskroom/versions
brew tap caskroom/fonts

# Install packages

apps=(
  adobe-acrobat-reader
  alfred
  airserver
  appcode
  atom
  bettertouchtool
  beyond-compare
  bitbar
  brave
  charles
  cyberduck
  dash2
  default-folder-x
  disk-inventory-x
  dropbox
  duet
  firefox
  firefoxnightly
  firefoxdeveloperedition
  flixtools
# flux
  font-fira-code
  fork
  forklift
# glimmerblocker
  github-desktop
  google-chrome
  google-chrome-canary
#  google-drive
  go2shell
#  hammerspoon
  handbrake
  hyper
  intellij-idea
  istat-menus
  iterm2
  kaleidoscope
  karabiner-elements
  keka
  keycastr
  macdown
  macpass
  now
  numi
  leap
  licecap
  microsoft-office
  mongodb
  mongodb-compass
  now
#  opera
  omnigraffle
  parallels-desktop
  postgres
  postico
  postman
  #TODO: runjs
  screenflow
##  slack
  sourcetree
  spectacle
##  spotify
  sublime-text
  skype
##  transmit
  transmission
  tripmode
  virtualbox
 visual-studio-code
  vlc
  vmware-fusion
  webstorm
  whatsapp
  
  # VIDEO EDITING
  avidemux
  lightworks 
)

brew cask install "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package

# Link Hammerspoon config
#if [ ! -d ~/.hammerspoon ]; then ln -sfv "$DOTFILES_DIR/etc/hammerspoon/" ~/.hammerspoon; fi
