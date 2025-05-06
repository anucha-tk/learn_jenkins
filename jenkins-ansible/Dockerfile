FROM jenkins/jenkins

USER root

# Install Ansible, curl, and git
RUN apt update && apt install -y ansible curl git

# Copy SSH key and set correct permissions
COPY ./remote-key /var/jenkins_home/ansible/
RUN chmod 600 /var/jenkins_home/ansible/remote-key && chown jenkins:jenkins /var/jenkins_home/ansible/remote-key

USER jenkins