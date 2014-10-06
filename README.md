dotfiles
========

My Dotfiles

To Install:

1. Change Shell to ZSH if it isn't

2. `curl -L http://install.ohmyz.sh | sh`

3. `git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick`

4. `printf '\nsource "$HOME/.homesick/repos/homeshick/homeshick.sh"' >> $HOME/.bashrc`

6. `source ~/.zshrc`

7. `git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim`

8. `vim +BundleInstall +qall` Installs your plugins and then quits both open windows

9. [Compile YCM](https://valloric.github.io/YouCompleteMe/)

10. [Compile Command-t](https://github.com/wincent/Command-T)

   `sudo apt-get install ruby-dev #Install Ruby header files if you don't have them already`

   `cd ~/.vim/bundle/command-t/ruby/command-t`

   `ruby extconf.rb`

   `make` 

11.(Optional) [Install Powerline fonts](https://powerline.readthedocs.org/en/latest/installation/linux.html#font-installation)
