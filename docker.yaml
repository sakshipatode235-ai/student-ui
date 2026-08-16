FROM  ubuntu:22.04
RUN  apt update && apt install -y openjdk-11-jdk maven

ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.120/bin/apache-tomcat-9.0.120.tar.gz /opt
WORKDIR  /opt
RUN tar -xvz apache-tomcat-9.0.120.tar.gz -C /opt/
ADD https://amzn-artifact-s3.s3.us-east-2.amazonaws.com/Artifacts/student.war /opt/apache-tomcat-9.0.120/webapps/student.war
COPY context.xml /opt/apache-tomcat-9.0.120/conf/contex.xml
RUN chmod +x /opt/apache-tomcat-9.0.120/bin/catalina.sh
EXPOSE 8080
CMD ["/opt/apache-tomcat-9.0.120/bin/catalina.sh","run"]
