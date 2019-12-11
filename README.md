Install your dot files in another machine
Once your configuration files(dot files) is under version control, it’s quite straightforward to import your settings to any machine that has git installed

Installation

    git clone https://github.com/gregjlee/dotfiles.git ~/.dotfiles


Create symlinks

    ln -s ~/.dotfiles/zshrc ~/.zshrc
    ln -s ~/.dotfiles/vimrc ~/.vimrc
