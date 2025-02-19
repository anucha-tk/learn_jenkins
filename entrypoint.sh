#!/bin/bash

echo "🚀 ------ Start Entrypoint ------"

# Ensure the script runs as root
if [ "$(id -u)" -ne 0 ]; then
  echo "❌ This script must be run as root!" >&2
  exit 1
fi
echo "✅ Running as root"

# Check if SSH_USER and SSH_PASSWORD are set
if [ -z "$SSH_USER" ] || [ -z "$SSH_PASSWORD" ]; then
  echo "⚠️ SSH_USER or SSH_PASSWORD is not set. Exiting!" >&2
  exit 1
fi
echo "🔑 SSH user and password variables are set"

# Update package list and install OpenSSH Server
echo "📦 Installing OpenSSH Server..."
apt update && apt install -y openssh-server && echo "✅ OpenSSH Server installed"
apt install -y neovim && echo "✅ Neovim installed"

# Create SSH user with the correct home directory
echo "👤 Creating SSH user: $SSH_USER"
useradd -m -d /home/jenkins -s /bin/bash "$SSH_USER" && echo "✅ User $SSH_USER created"
echo "$SSH_USER:$SSH_PASSWORD" | chpasswd && echo "🔑 Password set for $SSH_USER"

# Configure SSH settings (Avoid duplicate entries)
echo "🛠️ Configuring SSH settings..."
sed -i '/^PermitRootLogin/d' /etc/ssh/sshd_config
sed -i '/^AllowUsers/d' /etc/ssh/sshd_config
echo "PermitRootLogin no" >> /etc/ssh/sshd_config
echo "AllowUsers $SSH_USER" >> /etc/ssh/sshd_config
echo "✅ SSH settings configured"

# Start SSH service
echo "🚀 Starting SSH service..."
service ssh start && echo "✅ SSH service started"

# Start Jenkins process
echo "🛠️ Starting Jenkins..."
exec /usr/local/bin/jenkins.sh
