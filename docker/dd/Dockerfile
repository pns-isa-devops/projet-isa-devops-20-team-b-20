FROM tomee:8-jdk-7.0.1-plus
LABEL authors="Team B"

# Working inside the local TomEE system
WORKDIR /usr/local/tomee/

# Loading the executable server inside the image
COPY ./drone-delivery-backend.war ./webapps/.

# Creating the tomee/eemot user to access to the web admin console
COPY ./resources/tomcat-user.xml ./conf/tomcat-users.xml

# Allow one to access to the manager from outside the container
COPY ./resources/manager-context.xml ./webapps/manager/META-INF/context.xml

# Configure the link to the external partners
ENV dronepark_host=localhost
ENV dronepark_port=9090

ENV carrier_host=localhost
ENV carrier_port=9091

# Copy the startup script
COPY resources/start-dd.sh .
RUN ["chmod", "u+x", "./start-dd.sh"]

# Creating an health check verification to check TomEE status
HEALTHCHECK --interval=5s CMD curl --fail http://localhost:8080/ || exit 1

# exposing the 8080 port to support external connections
EXPOSE 8080

# Starting the service
ENTRYPOINT ["./start-dd.sh"]
