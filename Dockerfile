FROM ubuntu:22.04
RUN apt update -y && \ apt install openjdk-11-jdk maven 
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
    -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.120/bin/apache-tomcat-9.0.120.tar.gz /opt/
WORKDIR /opt/
COPY . .
RUN tar -xzf /opt/apache-tomcat-9.0.120.tar.gz -C /opt/
RUN mvn clean package && \
    cp /opt/target/*war /opt/apache-tomcat-9.0.120/webapps/student.war
COPY /opt/mysql-connector.jar /opt/apache-tomcat-9.0.120/lib/mysql-connector.jar
COPY context.xml /opt/apache-tomcat-9.0.120/conf/context.xml
RUN chmod +x /opt/apache-tomcat-9.0.120/bin/catalina.sh

EXPOSE 8080

CMD ["/opt/apache-tomcat-9.0.120/bin/catalina.sh", "run"]

