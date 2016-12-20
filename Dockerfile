FROM ubuntu:xenial

RUN apt-get update -yq && \
    apt-get install -yq locales ca-certificates

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen && update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 LANGUAGE=en

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt-get update -yq && \
    apt-get install -yq \
    bash git tmux vim inotify-tools sudo wget

################
# ALEXANDRIA DEPS #
################

RUN apt-get update -yq && \
    apt-get install -yq \
    openjdk-8-jdk python ffmpeg

############
# DATABASE #
############

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" >> /etc/apt/sources.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# Postgres
RUN apt-get update -yq && \
    apt-get install -yq \
    postgresql-9.5 postgresql-client-9.5

COPY files/db/pg_hba.conf /etc/postgresql/9.5/main/pg_hba.conf
COPY files/db/postgresql.conf /etc/postgresql/9.5/main/postgresql.conf
RUN /etc/init.d/postgresql start \
    && psql -U postgres -c "create user libreforge LOGIN SUPERUSER" \
    && createdb -U libreforge libreforge \
    && /etc/init.d/postgresql stop

########
# USER #
########

RUN echo "libre ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    useradd -m -g users -s /bin/bash libre && \
    passwd libre -d

USER libre

COPY files/env/lein /home/libre/.local/bin/lein
RUN sudo chmod +x /home/libre/.local/bin/lein
RUN bash -c "/home/libre/.local/bin/lein version"

ENV PATH=$PATH:.local/bin/

COPY files/env/db.sh /db.sh
COPY files/env/tmux.sh /tmux.sh
COPY files/env/deploy.sh /deploy.sh
COPY files/env/entrypoint.sh /entrypoint.sh

COPY files/env/tmux.conf /home/libre/.tmux.conf

RUN sudo chmod +x /db.sh
RUN sudo chmod +x /tmux.sh
RUN sudo chmod +x /deploy.sh
RUN sudo chmod +x /entrypoint.sh

WORKDIR /home/libre
