FROM jenkins/jnlp-slave:3.19-1
USER root
ENV DOTNET_RUNTIME_VERSION=2.0.6 \
DOTNET_SDK_VERSION=2.1.4
RUN apt-get update                                                          && \
apt-get install -y --no-install-recommends wget ruby curl apt-transport-https gpg && \
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
chmod +x ./kubectl && \
mv ./kubectl /usr/local/bin/kubectl && \
curl -sL https://aka.ms/InstallAzureCLIDeb | bash && \
apt-get update && \
apt-get install -y ca-certificates curl apt-transport-https lsb-release gnupg  && \
curl -sL https://packages.microsoft.com/keys/microsoft.asc |      gpg --dearmor |      tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null  && \
AZ_REPO=$(lsb_release -cs)  && \
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |      tee /etc/apt/sources.list.d/azure-cli.list  && \
apt-get update  && \
apt-get install -y azure-cli
USER jenkins
