# Réal's dotfiles

A fork of `s10wen/dotfiles` with some changes for my own personal preferences.

### Usage

Run `bootstrap.sh` to copy over all the dotfiles from this directory to `~`. The other scripts (`brew.sh`, `install-deps.sh`, and `.osx`) are pretty out of date, but look through them to see what might be useful -- mostly just `brew.sh`.

### Setup instructions

0. run `bootstrap.sh` from this repo to copy over all the dotfiles into `~`
1. go to https://brew.sh/ to copy command for installing Homebrew, then do `brew install git`
2. set caps-lock key to behave like escape on tap and control on hold
  * run `brew cask install karabiner-elements`
  * open it with `open -a Karabiner-Elements`
  * set up the rule. Go to "Complex modifications", "Add rule", "Import more rules...", and search for "Change caps_lock key" -- you are looking for a rule like "Change caps_lock to control if pressed with other keys, to escape if pressed alone.". Import the group containing this rule, then enable just the relevant rule.
  * you can quit out of the app now
3. fix iTerm2
  * enable proper command/option + arrow key behavior by going to Preferences (cmd+,) > Profiles > Keys > Presets > Import... and select the default-keymappings.itermkeymap file from this repo
  * fix the colors by switching to the Colors tab and under Color Presets... select Solarized Dark
  * download DejaVu Sans Mono (https://github.com/dejavu-fonts/dejavu-fonts/releases) and install the fonts (just double click the \*.ttf files and click install), then select it on the Text tab under Font (choose Book, 9 pt) -- also check "Use built-in Powerline glyphs"
    * (the code ligature fonts, like DejaVu Sans Code, are cool, but when this was last updated Vim didn't support ligatures for ASCII characters e.g. dash and bang, so ligatures like != and -> don't work)
  * fix clipboard behavior by going to Preferences > General > Selection and turning off "Copy to pasteboard on selection" and turning on "Applications in terminal may access clipboard"
4. set up vim
  * install the latest version: `brew install vim`
  * create helper directories: `mkdir ~/.vim/backups; mkdir ~/.vim/swaps; mkdir ~/.vim/undo`
  * install Vundle: `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
  * open a new instance of `vim` and run `:PluginInstall`
  * install python 3 with `brew install python`
  * restart vim!
5. install tmux
  * run `brew install tmux tmuxinator`
  * install tpm with `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
  * start up tmux with `tm`
  * install the plugins with `prefix I`
6. other stuff
  * `brew install hub`
  * `brew cask install vlc`
  * `brew install the_silver_searcher`
  * install Magnet
  * install Amphetamine
