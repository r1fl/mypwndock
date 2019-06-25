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
RUN apt-get install -y zsh \
	&& usermod -s /bin/zsh root

# Oh-my-zsh
RUN	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" \
	&& mv ~/.oh-my-zsh /usr/share/oh-my-zsh \
	&& echo "source ~/.zsh/.ohmyzsh" >> ~/.zsh/.zshrc

# Neovim
RUN apt-get install -y software-properties-common \
	&& add-apt-repository -y ppa:neovim-ppa/stable \
	&& apt-get update \
	&& apt-get -y install neovim

# Vim-plug
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
	&& pip2 install neovim

RUN nvim +PlugInstall +UpdateRemotePlugins +qall
WORKDIR /root/

