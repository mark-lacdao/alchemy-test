FROM mcr.microsoft.com/playwright:focal
USER root
ARG DIR=/test
WORKDIR $DIR

RUN apt-get update
RUN apt-get install -y python3.6 python3-pip

USER pwuser
COPY requirements.txt ./
RUN pip3 install --no-cache-dir --user -r requirements.txt

RUN ~/.local/bin/rfbrowser init
ENV NODE_PATH=/usr/lib/node_modules
ENV PATH="/home/pwuser/.local/bin:${PATH}"
RUN unset HTTP_PROXY HTTPS_PROXY
