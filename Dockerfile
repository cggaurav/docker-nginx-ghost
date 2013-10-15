FROM base
MAINTAINER cggaurav
RUN apt-get update
RUN apt-get install -y make gcc wget
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN apt-get install -y software-properties-common zip unzip
RUN apt-get install -y python-software-properties python g++ make
RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get install -y nodejs
RUN wget --no-check-certificate https://en.ghost.org/zip/ghost-0.3.2.zip -O ./ghost.zip
RUN unzip -ou ghost.zip -d ghost
RUN sed -i -e 's/127.0.0.1/0.0.0.0/g' ghost/config.example.js
RUN cd ghost && npm install --production
EXPOSE 2368
ADD run.sh /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
CMD ["/usr/local/bin/run"]