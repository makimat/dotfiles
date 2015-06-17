dotfiles
========

personal dotfiles for synchronization

General
=======

* Link \*rc, .lessfilter etc to your $HOME (remember to prefix the link with dot '.')

Vim
===

* git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
* vim +BundleInstall

Lessfilter
==========

* sudo apt-get install python-pygments
* set the following to your .zshrc
```sh
export LESS='-R'
export LESSOPEN='|~/.lessfilter %s'
```

Zsh
===

* Choose either zshrc.oh-my-zsh or zshrc.prezto
* With prezto link also zprofile and zpreztorc under your $HOME
* Oh-my-zsh further instruction: https://github.com/robbyrussell/oh-my-zsh
* Prezto further instruction: https://github.com/sorin-ionescu/prezto
