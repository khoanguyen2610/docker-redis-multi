FROM centos:centos7
RUN yum -y update &&\
    yum -y install software-properties-common wget git autoconf automake libtool openssl-devel make
WORKDIR /opt

RUN git clone https://github.com/DynomiteDB/dynomite.git &&\
    cd dynomite &&\
    autoreconf -fvi &&\
    ./configure --enable-debug=log &&\
    make
COPY dynomite_server.yml .
RUN cp /opt/dynomite_server.yml /opt/dynomite/conf/dynomite_server.yml
WORKDIR /opt/dynomite/
ENTRYPOINT ["src/dynomite", "--conf-file=conf/dynomite_server.yml", "-v11"]

CMD ["run"]