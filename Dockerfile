FROM openjdk:8-jre
FROM maven:3.5.3
RUN mkdir /app
ADD . /app/
WORKDIR /app
RUN mvn clean package
CMD java -jar /app/target/itoken-eureka-1.0.0-SNAPSHOT.jar --spring.profiles.active=prod
EXPOSE 8761
