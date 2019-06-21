FROM grazfather/pwndock:latest

# Pwndbg
RUN cd /opt && git clone https://github.com/pwndbg/pwndbg --depth 1 \
	&& cd ./pwndbg && ./setup.sh

# Dotfiles
RUN cd ~ \
	&& git clone --depth 1 https://github.com/r1fl/dots \
	&& find dots -maxdepth 1 -name '.*' -exec mv \{\} . \; \
	&& rm -r dots 

# Zsh
RUN apt-get install -y zsh

# Neovim
RUN apt-get install -y software-properties-common \
	&& add-apt-repository -y ppa:neovim-ppa/stable \
	&& apt-get update \
	&& apt-get -y install neovim

# Vim-plug
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN nvim -c PlugInstall

