dotfiles
========

My Dotfiles

To Install:

1. Change Shell to Zsh

   1. `sudo apt-get install zsh`
   
   2. `chsh -s $(which zsh)` or `which zsh >> ~/.bashrc` if chsh doesn't work for some reason

2. `curl -L http://install.ohmyz.sh | sh #Install Oh-My-Zsh`

3. `git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick #Install Homeshick`

4. `printf '\nsource "$HOME/.homesick/repos/homeshick/homeshick.sh"' >> $HOME/.bashrc #Add Homeshick to shell`

5. `source ~/.zshrc #Activate homeshick install`

6. `git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim #Install Vundle`

7. `vim +BundleInstall +qall #Installs your plugins and then quits both open windows`

8. [Compile YCM](https://valloric.github.io/YouCompleteMe/)
   
   1. `cd ~/.vim/bundle/YouCompleteMe`
   
   2. `./install.sh --clang-completer`
   
   3. `cd - #Get back to where you were` 

9. [Compile Command-t](https://github.com/wincent/Command-T)
   1. `sudo apt-get install ruby-dev #Install Ruby header files if you don't have them already`

   2. `cd ~/.vim/bundle/command-t/ruby/command-t`

   3. `ruby extconf.rb`

   4. `make` 

10. (Optional) [Install Powerline fonts](https://powerline.readthedocs.org/en/latest/installation/linux.html#font-installation)
