dotfiles
========

My Dotfiles

To Install:

1. Change Shell to Zsh:

   `sudo apt-get install zsh`
   
   `chsh -s $(which zsh)` or `which zsh >> ~/.bashrc` if chsh doesn't work for some reason (Note that this acts really weird at times, if you see a program isn't running try `exit`ing the shell, it seemed to work for me with bashrc method.)

2. Configure Vim and setup dotfiles links

   ```
   curl -L http://install.ohmyz.sh | sh
   git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
   printf '\nsource "$HOME/.homesick/repos/homeshick/homeshick.sh"' >> $HOME/.bashrc
   source ~/.zshrc
   git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
   homeshick clone royalaid/dotfiles
   homeshick link dotfiles
   vim +BundleInstall +qall
   ```
   
3. [Compile YCM](https://valloric.github.io/YouCompleteMe/)
   
   ```
   cd ~/.vim/bundle/YouCompleteMe
   ./install.sh --clang-completer
   cd - #Get back to where you were
   ```

4. (optional) [Compile Command-t](https://github.com/wincent/Command-T)

   ```
   sudo apt-get install ruby-dev #Install Ruby header files if you don't have them already
   cd ~/.vim/bundle/command-t/ruby/command-t
   ruby extconf.rb
   make
   ```

5. (optional) Setup [Hlint](https://github.com/dag/vim2hs#hlint) & [ghc-mod](https://github.com/eagletmt/neco-ghc#install) for Haskell

   ```
   sudo apt-get install haskell-platform
   cabal update
   ```
   
   `cabal install ghc-mod` (you may have to add `--force-reinstalls` for it to work
   
   `sudo apt-get install hlint`
   
6. (optional) Setup [Tern for Vim](https://github.com/marijnh/tern_for_vim)

   `curl -sL https://deb.nodesource.com/setup | sudo bash -` (latest) or `sudo apt-get install nodejs npm` (easy)
   
   As per the Tern For Vim instructions:

   "Caution: Because the node process is not run using your standard shell, the NVM version of node.js won't work. You need a global node executable."

   ```
   cd ~/.vim/bundle/tern_for_vim
   npm install
   ```

7. (Optional) [Install Powerline fonts](https://powerline.readthedocs.org/en/latest/installation/linux.html#font-installation)
