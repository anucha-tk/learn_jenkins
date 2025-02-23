# Step 1: Use Ubuntu 18.04 as the base image
FROM ubuntu:18.04

# Step 2: Update package list and install OpenSSH server
RUN apt-get update && \
    apt-get install -y openssh-server

# Step 3: Create a new user and configure SSH directory
RUN useradd remote_user && \
    echo "remote_user:1234" | chpasswd && \
    mkdir /home/remote_user/.ssh -p && \
    chmod 700 /home/remote_user/.ssh && \
    mkdir -p -m0755 /var/run/sshd

# Step 4: Copy the SSH public key into the `authorized_keys` file
COPY remote-key.pub /home/remote_user/.ssh/authorized_keys

# Step 5: Set correct permissions for the SSH directory and authorized_keys file
RUN chown remote_user:remote_user -R /home/remote_user && \
    chmod 400 /home/remote_user/.ssh/authorized_keys

# Step 6: Start the SSH service in the foreground (necessary for Docker container)
CMD /usr/sbin/sshd -D
