FROM ubuntu:latest

RUN apt-get update && apt-get install python3-pip openssh-client ca-certificates curl gnupg -y

RUN pip3 install --upgrade pip; \
    pip3 install --upgrade virtualenv; \
    pip3 install pywinrm[kerberos]; \
    pip3 install pywinrm; \
    pip3 install jmspath; \
    pip3 install requests; \
    python3 -m pip install ansible;

RUN pip3 install molecule

RUN ssh-keygen -q -t rsa -N '' -f /root/.ssh/id_rsa
RUN chmod 700 /root/.ssh
RUN chmod 600 /root/.ssh/id_rsa

RUN curl -sSL https://get.docker.com/ | sh

RUN ansible-galaxy collection install community.docker
RUN python3 -m pip install --user "molecule-plugins[docker]"

ENTRYPOINT sleep infinity