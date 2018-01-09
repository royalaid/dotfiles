# dotfiles
## This file is out of date as of commit [810e070](https://github.com/royalaid/dotfiles/commit/810e0702307a6243284847f384d40b5e88c3a648)



#My Dotfiles

##To Install:

1. Change Shell to Zsh:

   `sudo apt-get install zsh`
   
   `chsh -s $(which zsh)` or `which zsh >> ~/.bashrc` if chsh doesn't work for some reason (Note that this acts really weird at times, if you see a program isn't running try `exit`ing the shell, it seemed to work for me with bashrc method.)

2. Configure Vim and setup dotfiles links

   ```
   cd ~
   curl -L http://install.ohmyz.sh | sh
   
   # if on linux
   git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
   printf '\nsource "$HOME/.homesick/repos/homeshick/homeshick.sh"' >> $HOME/.bashrc

   # if on mac
   brew install homeshick

   source ~/.zshrc

   homeshick clone royalaid/dotfiles
   homeshick link dotfiles

   cd /tmp
   curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
   sh ./install.sh
   cd ~
   ``` 
3. Install nvm `curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash` 

4. Install fasd `brew install fasd`

5. Install fzf `brew install fzf`

6. Install exa `brew install exa`
    * Can be used via the `xa` alias

7. Install Ripgrep `brew install ripgrep` 

8. (Optional) [Install Powerline fonts](https://powerline.readthedocs.org/en/latest/installation/linux.html#font-installation)
    * Set the powerline fonts to be used by your terminal emulator

##Errata:

In order to setup macvim a few extra steps are required.

1. Install Xcode from the app store

2. Open Xcode, it will propmt you to install extras, this is required for
   macvim to compile

3. Run the below commands to configure MacVim
   ```
   xcode-select --install
   sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
   ```
4. Finally `brew install macvim --with-override-system-vim`
