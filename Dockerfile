# Stage-1 build the code
ARG maven_version=3.9.0
FROM maven:$maven_version As build
LABEL application_stack="JAVA"
LABEL Java_Version="17"
ARG maven_goal="package"
ADD . .   # we can use copy and add docker instructions
RUN mvn ${package}

# stage-2 run the application
ARG java_version="17.0-jdk"
FROM openjdk:$java_version
LABEL purpose="deploy"
COPY --from=build /target/spring-petclinic-3.4.0-SNAPSHOT.jar /
ENTRYPOINT ["java", "-jar"]
CMD ["spring-petclinic-3.4.0-SNAPSHOT.jar"]





