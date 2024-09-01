FROM python:3.10-slim

ENV ANSIBLE_CONFIG=./ansible.cfg
ENV PYTHONUNBUFFERED=1

RUN apt-get update && \
    apt-get install -y \
    sshpass \
    openssh-client \
    git \
    sudo \
    vim \
    && rm -rf /var/lib/apt/lists/*

COPY ansible/ /ansible

WORKDIR /ansible

COPY requirements.txt requirements.txt

RUN python3 -m venv env && \
    . env/bin/activate && \
    pip install --upgrade pip && \
    pip install -r requirements.txt && \
    ansible-galaxy install -r requirements.yml && \
    ansible-config dump --only-changed

CMD ["/bin/bash"]
