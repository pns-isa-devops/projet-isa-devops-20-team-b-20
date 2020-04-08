FROM openjdk:8
MAINTAINER Sébastien Mosser (mosser@i3s.unice.fr)

# Loading the executable server inside the image
COPY ./client-office-1.0-jar-with-dependencies.jar ./dd-client-office.jar

# Mounting a local directory to support file loading in the shell
VOLUME /host

# Running the client using the starting shell script
ENTRYPOINT ["java", "-jar", "./dd-client-office.jar"]

# Default arguments to be forwarded to the entry point
CMD ["localhost", "8080"]
