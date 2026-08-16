FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York

# Install Java, Maven, curl and unzip
RUN apt update && apt install -y \
    openjdk-11-jdk \
    maven \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
    -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws awscliv2.zip

# Verify AWS CLI
RUN aws --version

# Download Tomcat
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.120/bin/apache-tomcat-9.0.120.tar.gz /opt/

WORKDIR /opt

# Extract Tomcat
RUN tar -xzf apache-tomcat-9.0.120.tar.gz -C /opt/

# Copy WAR from S3
RUN aws s3 cp s3://amzn-artifact-s3/Artifacts/student.war \
    /opt/apache-tomcat-9.0.120/webapps/student.war

# Copy MySQL connector from S3
RUN aws s3 cp s3://amzn-artifact-s3/Artifacts/mysql-connector.jar \
    /opt/apache-tomcat-9.0.120/lib/mysql-connector.jar

# Copy Tomcat context configuration
COPY context.xml /opt/apache-tomcat-9.0.120/conf/context.xml

# Make Tomcat executable
RUN chmod +x /opt/apache-tomcat-9.0.120/bin/catalina.sh

EXPOSE 8080

CMD ["/opt/apache-tomcat-9.0.120/bin/catalina.sh", "run"]