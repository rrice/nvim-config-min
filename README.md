# Neovim Lazy Configuration

This is my Neovim minimal configuration for development.  It uses the plugins that I use the most and it is very
opinionated. Feel free to use this as a base for your configuration. 

# How I Use It

I actually clone this outside the standard `$HOME/.config` area so that I can continuously improve it easier.

So on your system, pick a senisble location. For example, maybe I have a place for my git clones at `$HOME/src`: 

````
$ cd $HOME/src
$ git clone https://github.com/rrice/nvim-config-min.git
````

To actually use this configuration, I may create a symbolic link to it and put it in the `$HOME/.config` directory:

````
$ ln -s $HOME/src/nvim-config-min $HOME/.config/nvim-config-min
````

Assuming that you may be using a POSIX shell, create an alias using the symbolic link. Create a unique
alias name for it. It can be any command you desire. Then, use the `NVIM_APPNAME` 
environment variable and set it to the name of your symbolic link:

````
$ alias my-nvim='NVIM_APPNAME=nvim-config-min nvim'
````

If you want this alias to persist across sessions, then you need to add this alias to your shell startup configuration,
like `$HOME/.bashrc`.


