dotfiles
========

My Dotfiles

To Install:

1. Change Shell to Zsh:

   `sudo apt-get install zsh`
   
   `chsh -s $(which zsh)` or `which zsh >> ~/.bashrc` if chsh doesn't work for some reason

2. Configure Vim and setup dotfiles links

`curl -L http://install.ohmyz.sh | sh #Install Oh-My-Zsh`
 
 `git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick #Install Homeshick`

`printf '\nsource "$HOME/.homesick/repos/homeshick/homeshick.sh"' >> $HOME/.bashrc #Add Homeshick to shell`

`source ~/.zshrc #Activate homeshick install`

`git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim #Install Vundle`

`homeshick clone royalaid/dotfiles`

`homeshick link dotfiles`

`vim +BundleInstall +qall #Installs your plugins and then quits both open windows`

3. [Compile YCM](https://valloric.github.io/YouCompleteMe/)
   
   1. `cd ~/.vim/bundle/YouCompleteMe`
   2. `./install.sh --clang-completer`
   3. `cd - #Get back to where you were` 

4. (optional) [Compile Command-t](https://github.com/wincent/Command-T)

   `sudo apt-get install ruby-dev #Install Ruby header files if you don't have them already`
   
   `cd ~/.vim/bundle/command-t/ruby/command-t`
   
   `ruby extconf.rb`
   
   `make`

5. (optional) Setup [Hlint](https://github.com/dag/vim2hs#hlint) & [ghc-mod](https://github.com/eagletmt/neco-ghc#install) for Haskell
   `sudo apt-get install haskell-platform`

   `cabal update`
   
   `cabal install ghc-mod` (you may have to add `--force-reinstalls` for it to work
   
   `sudo apt-get install hlint`
   

12. (Optional) [Install Powerline fonts](https://powerline.readthedocs.org/en/latest/installation/linux.html#font-installation)
