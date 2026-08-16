FROM ubuntu:22.04
RUN apt update && apt install -y \
    openjdk-11-jdk \
    maven \
    awscli
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.120/bin/apache-tomcat-9.0.120.tar.gz /opt/
WORKDIR /opt
RUN tar -xzf /opt/apache-tomcat-9.0.120.tar.gz -C /opt/
RUN aws s3 cp s3://amzn-artifact-s3/Artifacts/student.war \
    /opt/apache-tomcat-9.0.120/webapps/student.war

RUN aws s3 cp s3://amzn-artifact-s3/Artifacts/mysql-connector.jar \
    /opt/apache-tomcat-9.0.120/lib/mysql-connector.jar
COPY context.xml /opt/apache-tomcat-9.0.120/conf/context.xml
RUN chmod +x /opt/apache-tomcat-9.0.120/bin/catalina.sh
EXPOSE 8080
CMD ["/opt/apache-tomcat-9.0.120/bin/catalina.sh","run"]