FROM ubuntu:16.04

# Install dependencies
RUN apt-get update --yes && apt-get upgrade --yes
# RUN apt-get install software-properties-common
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common
RUN add-apt-repository ppa:fkrull/deadsnakes
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install git nodejs npm vim \
build-essential checkinstall libreadline-gplv2-dev libncursesw5-dev libssl-dev \
libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev python2.7 python-pip \
build-essential g++ 


RUN ln -s `which nodejs` /usr/bin/node

# Non-privileged user
RUN useradd -m interact

# Use our build context rather than re-cloning the repo we're already in
COPY . /home/interact/timelinejs3

# Make sure our user has the correct permissions
RUN chown -R interact /home/interact/timelinejs3

USER interact
WORKDIR /home/interact/timelinejs3

RUN cd /home/interact/timelinejs3

RUN pip install -r requirements.txt

# Install dependencies
# RUN npm install
