FROM mono:3.10
LABEL authors="Team B"

# Loading the executable server inside the image
COPY ./server.exe ./server.exe

# exposing the 9191 port to support external connections
EXPOSE 9191

# Running the .Net server as standalone
ENTRYPOINT ["mono", "./server.exe"]
CMD ["/standalone"]
