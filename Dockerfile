FROM ubuntu:20.04



ENV TZ=Indian
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update
RUN apt install -y tzdata


RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

RUN  apt install -y apache2
RUN  service apache2 start
RUN   cd /etc/apache2/mods-enabled 
RUN   ln -s ../mods-available/cgi.load
RUN   service apache2 restart
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]

COPY hw.sh /usr/lib/cgi-bin/

RUN  chmod +x /usr/lib/cgi-bin/hw.sh

CMD [curl http://127.0.0.1/cgi-bin/hw.sh]

  


