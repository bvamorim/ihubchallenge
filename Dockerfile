#FROM java:8
#EXPOSE 8080
#COPY src /home/app/src
#COPY pom.xml /home/app
#RUN mvn -f /home/app/pom.xml clean package
#ADD target/ihubchallenge-1.0.0.jar ihubchallenge-1.0.0.jar
#ENTRYPOINT ["java", "-jar", "ihubchallenge-1.0.0.jar"]

#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:11-jre-slim
COPY --from=build /home/app/target/ihubchallenge-1.0.0.jar /usr/local/lib/ihubchallenge-1.0.0.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/ihubchallenge-1.0.0.jar"]