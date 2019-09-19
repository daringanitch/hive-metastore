FROM bde2020/hive:2.3.2-postgresql-metastore

MAINTAINER Darin Ganitch <dganitch@illuminate.solutions>


ENV HIVE_VERSION 2.3.2

ENV HIVE_HOME /opt/hive
ENV PATH $HIVE_HOME/bin:$PATH
ENV HADOOP_HOME /opt/hadoop-$HADOOP_VERSION

WORKDIR /opt
COPY ./extra-libs/hadoop-aws-3.2.0.jar ./extra-libs/
COPY ./extra-libs/aws-java-sdk-bundle-1.11.375.jar ./extra-libs/

#Install Hive and PostgreSQL JDBC

#Spark should be compiled with Hive to be able to use it
#hive-site.xml should be copied to $SPARK_HOME/conf folder

#Custom configuration goes here
COPY ./extra-libs/hadoop-aws-3.2.0.jar ${HIVE_HOME}/lib/
COPY ./extra-libs/aws-java-sdk-bundle-1.11.375.jar ${HIVE_HOME}/lib/
RUN rm -rf ./extra-libs

COPY startup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/startup.sh

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 10000
EXPOSE 10002

ENTRYPOINT ["entrypoint.sh"]
CMD startup.sh
