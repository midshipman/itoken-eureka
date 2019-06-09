FROM openjdk:8-jre
FROM maven:3.5.3

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN mkdir /app
ADD . /app/
WORKDIR /app
RUN mvn clean package
#CMD java -jar /app/target/itoken-eureka-1.0.0-SNAPSHOT.jar --spring.profiles.active=prod
ENTRYPOINT ["dockerize", "-timeout", "5m", "-wait", "http://106.14.133.27:8888/itoken-eureka/prod/master", "java", "-jar", "/app/target/itoken-eureka-1.0.0-SNAPSHOT.jar", "--spring.profiles.active=prod"]
EXPOSE 8761
