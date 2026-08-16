FROM  ubuntu:22.04
RUN  apt update && apt install -y openjdk-11-jdk maven && \
     apt install aws-cli --classic

ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.120/bin/apache-tomcat-9.0.120.tar.gz /opt
WORKDIR  /opt
RUN tar -xvzf apache-tomcat-9.0.120.tar.gz -C /opt/
RUN aws s3 cp s3://amzn-artifact-s3/Artifacts/student.war \
    /opt/apache-tomcat-9.0.120/webapps/student.war
COPY context.xml /opt/apache-tomcat-9.0.120/conf/contex.xml
RUN chmod +x /opt/apache-tomcat-9.0.120/bin/catalina.sh
EXPOSE 8080
CMD ["/opt/apache-tomcat-9.0.120/bin/catalina.sh","run"]
