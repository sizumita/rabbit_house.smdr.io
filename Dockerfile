FROM ubuntu:latest

RUN apt-get update && apt-get upgrade

RUN apt-get install python3 pip3 -y

COPY . /home/root/

CMD ["bash"]
