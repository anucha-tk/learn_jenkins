# Step 1: Build Stage (Install mc)
FROM ubuntu:18.04 AS builder

# Install curl to download MinIO client
RUN apt update && \
    apt install -y curl sudo

# Download MinIO Client (mc)
RUN curl -sL https://dl.min.io/client/mc/release/linux-amd64/mc -o mc && \
    chmod +x mc

# Step 2: Final Stage (Minimal Image)
FROM ubuntu:18.04

# Copy the MinIO client from the builder stage
COPY --from=builder /mc /usr/local/bin/mc

# Install OpenSSH and MySQL for runtime
RUN apt update && \
    apt install -y openssh-server mysql-server

# Create a new user and configure SSH directory
RUN useradd remote_user && \
    echo "remote_user:1234" | chpasswd && \
    mkdir /home/remote_user/.ssh -p && \
    chmod 700 /home/remote_user/.ssh && \
    mkdir -p -m0755 /var/run/sshd

# Copy the SSH public key into the `authorized_keys` file
COPY remote-key.pub /home/remote_user/.ssh/authorized_keys

# Set correct permissions for SSH directory and keys
RUN chown remote_user:remote_user -R /home/remote_user && \
    chmod 400 /home/remote_user/.ssh/authorized_keys

# Expose the necessary ports
EXPOSE 22 3306

# Start MySQL and SSH services in the foreground
CMD service mysql start && /usr/sbin/sshd -D
