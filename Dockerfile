FROM tomcat:9.0-jdk11-openjdk-slim

ENV CATALINA_BASE /usr/local/tomcat
ENV PATH $CATALINA_BASE/bin:$PATH

COPY ./build/libs/db-view.war $CATALINA_BASE/webapps/
COPY ./server.xml $CATALINA_BASE/conf/server.xml

EXPOSE 8080

CMD ["catalina.sh", "run"]
