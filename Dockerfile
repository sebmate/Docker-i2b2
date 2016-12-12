FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y -y dos2unix vim unzip aptitude wget curl libcurl3 php5-curl apache2 libaio1 libapache2-mod-php5 perl sed bc nano openssh-server
RUN apt-get install -y -y openjdk-7-jre openjdk-7-jdk openjdk-7-jre-headless
RUN apt-get install -y -y dialog
#RUN apt-get install -y -y postgresql-client

ENV wizardVer i2b2wizard_2016-02-16

COPY $wizardVer.zip /root/
WORKDIR /root
RUN unzip $wizardVer.zip

COPY i2b2createdb-1707.zip /root/$wizardVer/packages
COPY i2b2core-src-1707.zip /root/$wizardVer/packages
COPY i2b2webclient-1707.zip /root/$wizardVer/packages

COPY axis2-1.6.2-war.zip /root/$wizardVer/packages
COPY apache-ant-1.8.2-bin.zip /root/$wizardVer/packages
COPY jboss-as-7.1.1.Final.zip /root/$wizardVer/packages

#COPY oracle-xe-universal_10.2.0.1-1.1_i386.deb /root/$wizardVer/packages
#COPY libaio_0.3.104-1_i386.deb /root/$wizardVer/packages

WORKDIR /root/$wizardVer

EXPOSE 80

RUN chmod +x wizard.sh
RUN find . -name "*.sh" -type f -exec dos2unix {} \;

#RUN ./wizard.sh --docker oracle

CMD /bin/bash

