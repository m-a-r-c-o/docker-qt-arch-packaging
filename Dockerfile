FROM base/archlinux
MAINTAINER Marco Cyriacks <marco@cyriacks.net>


# Install missing packages
RUN pacman --noconfirm -Syyu \
			git \
			openssh \
			htop \
			vim \
			sudo \
			tree \
			bash-completion \
			base-devel

RUN pacman --noconfirm -Syyu \
			qt5-base \
			qt5-tools

RUN pacman --noconfirm -Syyu \
			qt5-svg \
			qt5-webkit


# Add build user and build/install discount lib
RUN useradd -s /bin/bash -u 2000 build
USER build
RUN git clone --branch v2.2.2 https://aur.archlinux.org/discount.git /tmp/discount && cd /tmp/discount && makepkg
USER root
RUN pacman --noconfirm -U /tmp/discount/*.pkg.tar.xz

