FROM ubuntu:latest as builder

MAINTAINER coconutcracker v1.0

## Update and install necessary tools

RUN apt-get update -y
RUN apt-get install wget xz-utils -y

## Create folders and install Spearmint

WORKDIR /opt
RUN wget https://github.com/zturtleman/spearmint/releases/download/release-1.0.2/spearmint-1.0.2-linux.tar.xz
RUN tar -xvf spearmint-1.0.2-linux.tar.xz
RUN mv spearmint-1.0.2-linux spearmint

FROM ubuntu:latest
## Switch to unpriviledged user and run server
 
## RUN adduser q3server -D
COPY --from=builder /opt/spearmint /opt/spearmint
WORKDIR /opt/spearmint
## USER q3server
EXPOSE 27960/udp
ENTRYPOINT ["./spearmint-server_x86_64"]
## CMD ["+map", "q3dm17", "+exec", "server.cfg"]
