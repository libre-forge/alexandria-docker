FROM openjdk:8

#    ___                        _             _
#   |   \ ___ _ __  ___ _ _  __| |___ _ _  __(_)___ ___
#   | |) / -_) '_ \/ -_) ' \/ _` / -_) ' \/ _| / -_|_-<
#   |___/\___| .__/\___|_||_\__,_\___|_||_\__|_\___/__/
#            |_|
#
RUN apt-get update && apt-get install -yq \
    sudo \
    openjfx \
    tmux \
    vim \
	unzip \
    xz-utils \
    curl \
    rlwrap \
    openssh-client \
	postgresql-client && \
    apt-get clean && \
    rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

#    _   _
#   | | | |___ ___ _ _
#   | |_| (_-</ -_) '_|
#    \___//__/\___|_|
#

RUN echo "dev ALL=(ALL) PASSWD:ALL" >> /etc/sudoers && \
    useradd dev -d /home/dev -s /bin/bash && \
    cp -r /etc/skel /home/dev && \
    chown dev -R /home/dev

RUN echo 'dev:devpassword123' | chpasswd

#    _____             _
#   |_   _| _ __ ___ _(_)___
#     | || '_/ _` \ V / (_-<
#     |_||_| \__,_|\_/|_/__/
#
RUN apt-get update && \
    apt-get install zip && \
    apt-get install -yq build-essential ruby-dev ruby make && \
    gem install travis -v 1.8.2 --no-rdoc --no-ri && \
    apt-get clean && \
    rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

#    ___           _      _                      _
#   | _ ) ___  ___| |_ __| |_ _ _ __ _ _ __ _ __(_)_ _  __ _
#   | _ \/ _ \/ _ \  _(_-<  _| '_/ _` | '_ \ '_ \ | ' \/ _` |
#   |___/\___/\___/\__/__/\__|_| \__,_| .__/ .__/_|_||_\__, |
#                                     |_|  |_|         |___/
#
# Setting default workdir, exposing most common ports and executing
# tmux
#
ENV HOME_BIN /home/dev/.bin

COPY files/entrypoint.sh /home/dev/.bin/
COPY files/tmux.conf /home/dev/.tmux.conf

RUN chmod +x /home/dev/.bin/*.sh

#       ___   ____  __   _
#    _ | \ \ / /  \/  | | |   __ _ _ _  __ _ _  _ __ _ __ _ ___ ___
#   | || |\ V /| |\/| | | |__/ _` | ' \/ _` | || / _` / _` / -_|_-<
#    \__/  \_/ |_|  |_| |____\__,_|_||_\__, |\_,_\__,_\__, \___/__/
#                                      |___/          |___/
#
#
# SDK-MAN == :)
USER dev

RUN curl -s get.sdkman.io | bash
RUN bash -c "source /home/dev/.sdkman/bin/sdkman-init.sh"

WORKDIR /home/dev
ENTRYPOINT [".bin/entrypoint.sh"]
