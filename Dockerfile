FROM isaackuang/centos-base:7

ENV PGDATA=/data/postgresql

RUN yum install -y https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm && \
    yum install -y  postgresql96-server postgresql96-contrib postgresql96-devel && \
    mkdir -p $PGDATA && \
    chown -R postgres.postgres $PGDATA && \
    yum install -y epel-release make gcc && \
    cd /tmp && \
    wget https://github.com/redis/hiredis/archive/v0.14.0.zip && \
    unzip v0.14.0.zip && \
    cd hiredis-0.14.0 && \
    make && make install && \
    cd /tmp && \
    wget https://github.com/pg-redis-fdw/redis_fdw/archive/REL9_6_STABLE.zip && \
    unzip REL9_6_STABLE.zip && \
    cd redis_fdw-REL9_6_STABLE && \
    PATH=/usr/pgsql-9.6//bin/:$PATH make USE_PGXS=1 && \
    PATH=/usr/pgsql-9.6//bin/:$PATH make USE_PGXS=1 install && \
    cd / && rm -rf /tmp/*
    
COPY config /
