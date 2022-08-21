FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

# Set Bash as default shell
# RUN rm /bin/sh && ln -s /bin/bash /bin/sh
SHELL ["/bin/bash", "-c"]

# Update local caches repo and upgrade the OS
RUN apt update && \
# apt upgrade -y && \

# Install common file manipulator tools (e.g editors)
apt -y install bash jq vim nano git bash-completion \

# Common required packages (e.g. for Azure CLI etc)
ca-certificates curl apt-transport-https lsb-release gnupg snapd \

# Network & IdM related utilities
curl wget binutils dnsutils ldap-utils openssl ntp ntpdate \
realmd libnss-sss libpam-sss sssd sssd-tools krb5-user samba adcli

# Cloud provider CLIs
## Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash && \

## AWS CLI
apt -y install awscli

# AWS SSM agent
RUN mkdir /tmp/ssm && \
cd /tmp/ssm && \
curl https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb -o amazon-ssm-agent.deb && \
dpkg -i amazon-ssm-agent.deb && rm -f amazon-ssm-agent.deb \
service enable amazon-ssm-agent

# Latest version of kubectl
RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg && \
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list && \
apt-get update && \
apt-get install -y kubectl

# Auto-completion and aliases
RUN echo 'source <(kubectl completion bash)' >>~/.bashrc && \
echo 'alias k=kubectl' >>~/.bashrc && \
. ~/.bashrc

# Install Helm
RUN curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | tee /usr/share/keyrings/helm.gpg > /dev/null && \
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list && \
apt-get update && apt-get install helm
