FROM docker.io/fedora:latest

RUN yum -y update && \
	yum install -y git python3 libvirt-python3 python3-pyghmi python3-zmq python3-pbr python3-urllib3 python3-pip golang golang-github-pebbe-zmq4-devel pipenv && \
	yum install -y vim net-tools ipmitool && \
	mkdir /root/git && \
	cd /root/git && \
	git clone https://github.com/colonwq/go-virtualbmc.git && \
	pip3 install requests urllib3 pbr
ADD . /root/git/virtualbmc
RUN mkdir /.vbmc && \
    chmod 777 /.vbmc && \
    mkdir /.cache && \
    chmod 777 /.cache
RUN echo "export PYTHONPATH=/root/git/virtualbmc:/root/git/rest_api/:/root/git/virtualbmc/virtualbmc" > /root/vbmcd.sh
RUN echo "cd /root/git/virtualbmc" >> /root/vbmcd.sh
RUN echo "python3 virtualbmc/cmd/vbmcd.py --foreground" >> /root/vbmcd.sh
RUN echo "printenv | sort" >> /root/vbmcd.sh

RUN chmod +x /root/vbmcd.sh
RUN mkdir -p /var/run/virtualbmc/domains
ENV GOPATH /usr/share/gocode
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/git/go-virtualbmc
#ENTRYPOINT /root/vbmcd.sh

RUN echo "while [ true ] ; do sleep 20; echo 'going to sleep'; done " > /root/loop.sh
RUN chmod +x /root/loop.sh
#ENTRYPOINT /root/loop.sh 
