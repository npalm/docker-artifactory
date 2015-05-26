FROM java:8
MAINTAINER Niek Palm "dev.npalm@gmail.com"

ENV ARTIFACTORY_VERSION 3.7.0
ENV ARTIFACTORY_URL http://dl.bintray.com/content/jfrog/artifactory/artifactory-$ARTIFACTORY_VERSION.zip?direct

ADD $ARTIFACTORY_URL /artifactory.zip
RUN unzip /artifactory.zip -d / \ 
    && mv /artifactory-* /artifactory \
    && rm -f /artifactory.zip

# Change memory settings
RUN sed -i -e 's/Xmx2g/Xmx512m/g' /artifactory/bin/artifactory.default

# Expose the default endpoint
EXPOSE 8081

VOLUME ["/artifactory/data", "/artifactory/backup", "/artifactory/logs"]

# Run the embedded tomcat container
ENTRYPOINT /artifactory/bin/artifactory.sh
