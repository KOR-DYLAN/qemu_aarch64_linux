#!/bin/bash
echo "configuring ssh..."
ssh-keygen -t rsa -f /home/$USER/.ssh/id_rsa -q -P ""
touch /home/$USER/.ssh/authorized_keys
touch /home/$USER/.ssh/known_hosts
chmod 700 /home/$USER/.ssh
chmod 600 /home/$USER/.ssh/id_rsa
chmod 644 /home/$USER/.ssh/id_rsa.pub
chmod 644 /home/$USER/.ssh/authorized_keys
chmod 644 /home/$USER/.ssh/known_hosts