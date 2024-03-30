#!/bin/bash

# Replace 'your_new_user' with the desired username

# Create the new user and add them to the 'sudo' group
adduser --gecos "" $NEW_USER
echo "$NEW_USER:$USER_PASSWORD" | chpasswd
usermod -aG sudo $NEW_USER

# Create a .ssh directory for the new user
mkdir -p /home/$NEW_USER/.ssh
chmod 700 /home/$NEW_USER/.ssh

# Copy the public key to the new user's .ssh directory
cp /root/$KEY_FILENAME /home/$NEW_USER/.ssh/
chmod 600 /home/$NEW_USER/.ssh/$KEY_FILENAME

# Change ownership of the .ssh directory to the new user
chown -R $NEW_USER:$NEW_USER /home/$NEW_USER/.ssh

# OPTIONAL: Copy Docker installation script to new user's home directory
# cp path_to_your_docker_script.sh /home/$NEW_USER/
# chown $NEW_USER:$NEW_USER /home/$NEW_USER/path_to_your_docker_script.sh

su - $NEW_USER
echo "User $NEW_USER created and configured."

sudo chmod +x ./docker/install.sh
