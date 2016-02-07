#!/usr/bin/env sh

groupadd -f --gid $HOST_GID $HOST_GROUP || true
useradd -m --gid $HOST_GROUP --uid $HOST_UID --groups sudo --shell /bin/bash $HOST_USER
echo "$HOST_USER:`openssl rand -base64 37 | cut -c1-37`" | chpasswd

mkdir -p /home/$HOST_USER/.ssh
cp -f /root/.ssh/authorized_keys /home/$HOST_USER/.ssh/authorized_keys
chmod -R og-rwX /home/$HOST_USER/.ssh
chown -R $HOST_USER:$HOST_GROUP /home/$HOST_USER/.ssh

echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

/etc/init.d/ssh restart

su - $HOST_USER
