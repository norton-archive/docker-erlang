FROM phusion/baseimage:0.9.18
MAINTAINER Joseph Wayne Norton <norton@alum.mit.edu>

WORKDIR /root

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

# See : https://github.com/phusion/baseimage-docker/issues/58
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# See : https://github.com/phusion/baseimage-docker/issues/119
RUN echo /root > /etc/container_environment/HOME

RUN curl --fail -L -O http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
RUN dpkg -i erlang-solutions_1.0_all.deb
RUN apt-get update && \
    apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
    apt-get install -y \
    esl-erlang \
    git \
    unzip \
    wget
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

ADD your_key.pub /tmp/your_key.pub
RUN cat /tmp/your_key.pub >> /root/.ssh/authorized_keys && rm -f /tmp/your_key.pub

ADD startup.sh /root/startup.sh
RUN chmod +x /root/startup.sh

CMD ["/sbin/my_init", "--quiet"]
